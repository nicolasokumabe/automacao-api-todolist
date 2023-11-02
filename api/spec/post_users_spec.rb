require_relative "routes/users"

describe "POST /users" do
  context "cadastro com sucesso" do
    before(:all) do
      @result = Users.new.cadastro("Nicolas Kumabe", "nicolasokumabe", "pwd123")
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
      @result = Users.new.cadastro(
        "Nicolas Kumabe",
        "nicolasokumabe",
        "pwd123",
      )
    end
    it "valida status code" do
      expect(@result.code).to eql 400
    end

    it "valida id do usuário" do
      expect(@result.parsed_response).to eql "Usuário Já existe"
    end
  end
end
