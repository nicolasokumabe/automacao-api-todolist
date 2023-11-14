describe "DELETE /tasks/{task_id}" do
  before(:all) do
    # Criar um novo usuário
    @payload = {
      name: "Jude Bellingham",
      username: "bellinghol",
      password: "#Oiluminado",
    }
    Users.new.create(@payload)

    @seg_payload = {
      name: "Vinícius Júnior",
      username: "vinijr",
      password: "Camisa7",
    }
    Users.new.create(@seg_payload)

    #Criar uma nova tarefa
    payload_task = {
      description: "Quantidade de gols",
      title: "Real Madrid",
      priority: "BAIXA",
      startAt: "2033-11-27T12:30:00",
      endAt: "2033-11-27T15:35:00",
    }
    @result = Tasks.new.create(payload_task, @payload[:username], @payload[:password])
    @task_id = @result.parsed_response["id"]
  end

  context "tarefa nao encontrada" do
    before(:all) do
      task_inexist = "00000000-0000-0000-0000-000000000000"
      @result = Tasks.new.delete_task(task_inexist, @payload[:username], @payload[:password])
    end

    it "valida status code 404" do
      expect(@result.code).to eql 404
    end

    it "valida mensagem de erro" do
      expect(@result.parsed_response["error"]).to eql "Tarefa não encontrada"
    end
  end

  context "tarefa de outrem" do
    before(:all) do
      @result = Tasks.new.delete_task(@task_id, @seg_payload[:username], @seg_payload[:password])
    end

    it "valida status code 401" do
      expect(@result.code).to eql 401
    end

    it "valida mensagem de erro" do
      expect(@result.parsed_response["error"]).to eql "Usuário não tem permissão para excluir essa tarefa"
    end
  end

  context "tarefa deletada com sucesso" do
    before(:all) do
      @result = Tasks.new.delete_task(@task_id, @payload[:username], @payload[:password])
    end

    it "valida status code 200" do
      expect(@result.code).to eql 200
    end

    it "valida mensagem de sucesso" do
      expect(@result.parsed_response["message"]).to eql "Tarefa deletada com sucesso"
    end
  end
end
