describe "GET /task/{task_id}" do
  before(:all) do
    # Criar um novo usuário
    @payload = { name: "Tom Mate", username: "tomate", password: "pwd123" }
    @result = Users.new.create(@payload)
    @user_id = @result.parsed_response["id"]

    #Criar uma nova tarefa
    payload_task = {
      description: "ordem dos livros de ficção",
      title: "livros de ficção",
      priority: "BAIXA",
      startAt: "2033-11-27T12:30:00",
      endAt: "2033-11-27T15:35:00",
    }
    @result = Tasks.new.create(payload_task, @payload[:username], @payload[:password])
    @task_id = @result.parsed_response["id"]
  end

  context "obter uma unica tarefa" do
    before(:all) do
      @result = Tasks.new.find_spcfc_task(@task_id, @payload[:username], @payload[:password])
    end

    it "valida status code 200" do
      expect(@result.code).to eql 200
    end

    it "valida resposta da API" do
      expected_response = {
        "id" => @task_id,
        "description" => "ordem dos livros de ficção",
        "title" => "livros de ficção",
        "startAt" => "2033-11-27T12:30:00",
        "endAt" => "2033-11-27T15:35:00",
        "priority" => "BAIXA",
        "idUser" => @user_id,
      }

      expect(@result.parsed_response).to include(expected_response)
    end
  end
end
