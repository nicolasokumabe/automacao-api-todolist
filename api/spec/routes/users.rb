require "httparty"

class Users
  include HTTParty
  base_uri "http://localhost:8080"

  def cadastro(name, username, pass)
    payload = { name: name, username: username, password: pass }

    return self.class.post(
             "/users/",
             body: payload.to_json,
             headers: {
               "Content-Type": "application/json",
             },
           )
  end
end
