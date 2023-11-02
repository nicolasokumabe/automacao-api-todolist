require_relative "routes/users"

describe "POST /users" do
  context "cadastro com sucesso" do
    before(:all) do
      payload = { name: "Nicolas Kumabe", username: "nicolasokumabe", password: "pwd123" }
      @result = Users.new.cadastro(payload)
    end
    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuário" do
      expect(@result.parsed_response["id"].length).to eql 36
    end
  end

  context "usuário existente" do
    before(:all) do
      payload = { name: "Nicolas Kumabe", username: "nicolasokumabe", password: "pwd123" }

      @result = Users.new.cadastro(payload)
    end
    it "valida status code" do
      expect(@result.code).to eql 400
    end

    it "valida id do usuário" do
      expect(@result.parsed_response).to eql "Usuário Já existe"
    end
  end
end
