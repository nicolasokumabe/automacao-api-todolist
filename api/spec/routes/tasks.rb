require_relative "base_api"

class Tasks < BaseApi
  def create(payload)
    username = "nicolasokumabe"
    password = "pwd123"

    basic_token = Base64.strict_encode64("#{username}:#{password}")

    return self.class.post(
             "/tasks/",
             body: payload.to_json,
             headers: {
               "Content-Type": "application/json",
               "Authorization": "Basic #{basic_token}",
             },
           )
  end
end
