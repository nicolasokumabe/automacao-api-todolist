require "httparty"

describe "POST /users" do
  context "cadastro com sucesso" do
    before(:all) do
      payload = {
        name: "Nicolas Kumabe",
        username: "nicolasokumabe",
        password: "pwd123",
      }

      @result = HTTParty.post(
        "http://localhost:8080/users/",
        body: payload.to_json,
        headers: {
          "Content-Type": "application/json",
        },
      )
    end
    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuário" do
      expect(@result.parsed_response["id"].length).to eql 36
    end
  end
end
