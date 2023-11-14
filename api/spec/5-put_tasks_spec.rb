describe "PUT /tasks/{task_id}" do
  before(:all) do
    # Criar um novo usuário
    @payload = {
      name: "Chris Bumstead",
      username: "CBUM",
      password: "meteor",
    }
    Users.new.create(@payload)

    # Criar uma nova tarefa
    payload_task = {
      description: "Alimentos para a perda de peso",
      title: "Cutting ",
      priority: "ALTA",
      startAt: "2033-11-27T12:30:00",
      endAt: "2033-11-27T15:35:00",
    }
    @result = Tasks.new.create(payload_task, @payload[:username], @payload[:password])
    @task_id = @result.parsed_response["id"]
  end

  context "Tarefa modificada com sucesso" do
    before(:all) do
      # objeto
      @payload_change = {
        description: "Oque comer no Pré-Contest",
        title: "Pré-Contest ",
        priority: "MUITO ALTA",
        startAt: "2033-12-10T12:00:00",
        endAt: "2033-12-29T23:59:00",
      }
      @result = Tasks.new.change(@payload_change, @task_id, @payload[:username], @payload[:password])
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida mudança da descrição" do
      expect(@result.parsed_response["description"]).to eql @payload_change[:description]
    end

    it "valida mudança do titulo" do
      expect(@result.parsed_response["title"]).to eql @payload_change[:title]
    end

    it "valida mudança da prioridade" do
      expect(@result.parsed_response["priority"]).to eql @payload_change[:priority]
    end

    it "valida mudança da data inicial" do
      expect(@result.parsed_response["startAt"]).to eql @payload_change[:startAt]
    end

    it "valida mudança da data final" do
      expect(@result.parsed_response["endAt"]).to eql @payload_change[:endAt]
    end

    it "valida toda a mudança" do
      # "array"
      expected_response = {
        "description" => @payload_change[:description],
        "title" => @payload_change[:title],
        "priority" => @payload_change[:priority],
        "startAt" => @payload_change[:startAt],
        "endAt" => @payload_change[:endAt],
      }
      expect(@result.parsed_response).to include(expected_response)
    end
  end
end
