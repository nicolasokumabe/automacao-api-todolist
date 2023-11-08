require_relative "base_api"

class Tasks < BaseApi
  username = "nicolasokumabe"
  password = "pwd123"

  @basic_token = Base64.strict_encode64("#{username}:#{password}")

  def create(payload)
    return self.class.post(
             "/tasks/",
             body: payload.to_json,
             headers: {
               "Content-Type": "application/json",
               "Authorization": "Basic #{@basic_token}",
             },
           )
  end

  def find_by_taks()
    return self.class.get(
             "/tasks/",
             headers: {
               #  "user_id": user_id,
               "Authorization": "Basic #{@basic_token}",
             },
           )
  end

  def find_spcfc_task(task_id)
    return self.class.get(
             "/tasks/#{task_id}",
             headers: {
               #  "user_id": user_id,
               "Authorization": "Basic #{@basic_token}",
             },
           )
  end
end
