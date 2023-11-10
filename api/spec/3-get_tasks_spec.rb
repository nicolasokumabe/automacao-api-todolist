describe "GET /tasks" do
  before(:all) do
    @payload = {
      name: "Caps Lock",
      username: "capsulado",
      password: "123456",
    }
    @result = Users.new.create(@payload)
    @user_id = @result.parsed_response["id"]

    payload_task = {
      description: "Planejamento da minha empresa",
      title: "Organização",
      priority: "ALTA",
      startAt: "2033-11-27T12:30:00",
      endAt: "2033-11-27T15:35:00",
    }
    @result = Tasks.new.create(payload_task, @payload[:username], @payload[:password])
    @first_task_id = @result.parsed_response["id"]

    payload_task = {
      description: "Funcionários da empresa a serem contratados",
      title: "Contratação",
      priority: "ALTA",
      startAt: "2023-11-27T12:30:00",
      endAt: "2023-11-27T15:35:00",
    }
    @result = Tasks.new.create(payload_task, @payload[:username], @payload[:password])
    @second_task_id = @result.parsed_response["id"]
  end

  context "obter tarefas" do
    before(:all) do
      @result = Tasks.new.find_by_taks(@payload[:username], @payload[:password])
    end

    it "valida status code 200" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuário" do
      @result.parsed_response.each do |task|
        expect(task["idUser"]).to eql @user_id
      end
    end

    # it "valida id do usuário" do
    #   expect(@result.parsed_response["idUser"]).to eql @user_id
    # end

    it "valida id das tasks" do
      expect(@result.parsed_response[0]["id"]).to eql @first_task_id
      expect(@result.parsed_response[1]["id"]).to eql @second_task_id
    end
  end
end
