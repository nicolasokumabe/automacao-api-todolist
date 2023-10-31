require "httparty"

describe "POST /users" do
  it "cadastro com sucesso" do
    payload = {
      name: "Nicolas Kumabe",
      username: "nicolasokumabe",
      password: "pwd123",
    }

    result = HTTParty.post(
      "http://localhost:8080/users/",
      body: payload.to_json,
      headers: {
        "Content-Type": "application/json",
      },
    )

    expect(result.code).to eql 200
    expect(result.parsed_response["id"].length).to eql 36
  end
end
