require_relative "routes/tasks"

describe "POST /tasks" do
  context "nova tarefa" do
    before(:all) do
      payload = {
        description: "Tarefa para a API nicolasokumabe",
        title: "API nicolasokumabe",
        priority: "ALTA",
        startAt: "2023-11-27T12:30:00",
        endAt: "2023-11-27T15:35:00",
      }
      @result = Tasks.new.create(payload)
    end

    it "valida status code 200" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuário" do
      expect(@result.parsed_response["id"].length).to eql 36
    end
  end
end
