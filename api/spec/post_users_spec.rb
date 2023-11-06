require_relative "routes/users"

describe "POST /users" do
  context "cadastro com sucesso" do
    before(:all) do
      payload = { name: "Nicolas Kumabe", username: "nicolasokumabe", password: "pwd123" }
      @result = Users.new.cadastro(payload)
    end
    it "valida status code 200" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuário" do
      expect(@result.parsed_response["id"].length).to eql 36
    end
  end

  examples = [
    {
      title: "usuario existente",
      payload: { name: "Nicolas Kumabe", username: "nicolasokumabe", password: "pwd123" },
      code: 400,
      error: "Usuário já existe",
    },
    {
      title: "username em branco",
      payload: { name: "Nicolas Kumabe", username: "", password: "pwd123" },
      code: 400,
      error: "Username é um campo obrigatório",
    },
    {
      title: "senha em branco",
      payload: { name: "Nicolas Kumabe", username: "nicolasokumabe", password: "" },
      code: 400,
      error: "Senha é um campo obrigatório",
    },
    {
      title: "nome em branco",
      payload: { name: "", username: "nicolasokumabe", password: "pwd123" },
      code: 400,
      error: "Nome é um campo obrigatório",
    },
    {
      title: "sem o campo nome",
      payload: { username: "nicolasokumabe", password: "pwd123" },
      code: 400,
      error: "Nome é um campo obrigatório",
    },
    {
      title: "sem o campo username",
      payload: { name: "Nicolas Kumabe", password: "pwd123" },
      code: 400,
      error: "Username é um campo obrigatório",
    },
    {
      title: "sem o campo senha",
      payload: { name: "Nicolas Kumabe", username: "nicolasokumabe" },
      code: 400,
      error: "Senha é um campo obrigatório",
    },
  ]

  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Users.new.cadastro(e[:payload])
      end
      it "valida status code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end

      it "valida id do usuário" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end
