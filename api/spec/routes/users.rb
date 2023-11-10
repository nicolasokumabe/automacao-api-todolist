require_relative "base_api"

class Users < BaseApi
  def create(payload)
    return self.class.post(
             "/users/",
             body: payload.to_json,
             headers: {
               "Content-Type": "application/json",
             },
           )
  end

  def change_pass(payload)
    return self.class.patch(
             "/users/change-password",
             body: payload.to_json,
             headers: {
               "Content-Type": "application/json",
             },
           )
  end
end
