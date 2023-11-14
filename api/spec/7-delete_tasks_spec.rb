describe "DELETE /tasks/{id}" do
  before(:all) do
    # Criar um novo usuário
    @payload = {
      name: "Jude Bellingham",
      username: "bellinghol",
      password: "#Oiluminado",
    }
    Users.new.create(@payload)

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

  context "tarefa deletada com sucesso" do
    before(:all) do
      @result = Tasks.new.delete_task(@task_id, @payload[:username], @payload[:password])
    end

    it "valida status code 200" do
      expect(@result.code).to eql 200
    end

    it "valida mensagem de sucesso" do
      expect(@result.parsed_response["message"]).to eql "Usuário deletado com sucesso"
    end
  end

  context "obter uma unica tarefa" do
    before(:all) do
      @result = Tasks.new.find_spcfc_task(@task_id, @payload[:username], @payload[:password])
    end

    it "valida status code 200" do
      expect(@result.code).to eql 200
    end

    it "valida mensagem de sucesso" do
      expect(@result.parsed_response["message"]).to eql "Usuário deletado com sucesso"
    end
  end
end

Tarefa não encontrada
Usuário não tem permissão para excluir essa tarefa
Tarefa deletada com sucesso
