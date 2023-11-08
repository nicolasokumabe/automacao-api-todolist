require_relative "base_api"

class Tasks < BaseApi
  def create(payload, username, password)
    # username = "nicolasokumabe"
    # password = "pwd123"

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

  def find_by_taks(username, password)
    # username = "capsulado"
    # password = "123456"

    basic_token = Base64.strict_encode64("#{username}:#{password}")

    return self.class.get(
             "/tasks/",
             headers: {
               #  "user_id": user_id,
               "Authorization": "Basic #{basic_token}",
             },
           )
  end

  def find_spcfc_task(task_id)
    username = "nicolasokumabe"
    password = "pwd123"

    basic_token = Base64.strict_encode64("#{username}:#{password}")

    return self.class.get(
             "/tasks/#{task_id}",
             headers: {
               #  "user_id": user_id,
               "Authorization": "Basic #{basic_token}",
             },
           )
  end
end
