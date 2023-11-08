require_relative "routes/tasks"

describe "POST /tasks" do
  before(:all) do
    @payload = { name: "Roger Guedes", username: "arabia", password: "coringa123" }
    @result = Users.new.create(@payload)
  end

  context "task criada com sucesso" do
    before(:all) do
      payload_task = {
        description: "Tarefa para a API nicolasokumabe",
        title: "API nicolasokumabe",
        priority: "ALTA",
        startAt: "2023-11-27T12:30:00",
        endAt: "2023-11-27T15:35:00",
      }
      @result = Tasks.new.create(payload_task, @payload[:username], @payload[:password])
    end

    it "valida status code 200" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuário" do
      expect(@result.parsed_response["id"].length).to eql 36
    end
  end

  examples = [
    {
      title: "descricao em branco",
      payload_task: {
        description: "",
        title: "API nicolasokumabe",
        priority: "ALTA",
        startAt: "2023-11-27T12:30:00",
        endAt: "2023-11-27T15:35:00",
      },
      code: 400,
      error: "Descrição é um campo obrigatório",
    },
    {
      title: "titulo em branco",
      payload_task: {
        description: "Tarefa para a API nicolasokumabe",
        title: "",
        priority: "ALTA",
        startAt: "2023-11-27T12:30:00",
        endAt: "2023-11-27T15:35:00",
      },
      code: 400,
      error: "Título é um campo obrigatório",
    },
    {
      title: "prioridade em branco",
      payload_task: {
        description: "Tarefa para a API nicolasokumabe",
        title: "API nicolasokumabe",
        priority: "",
        startAt: "2023-11-27T12:30:00",
        endAt: "2023-11-27T15:35:00",
      },
      code: 400,
      error: "Prioridade é um campo obrigatório",
    },
    {
      title: "data de inicio em branco",
      payload_task: {
        description: "Tarefa para a API nicolasokumabe",
        title: "API nicolasokumabe",
        priority: "ALTA",
        startAt: "",
        endAt: "2023-11-27T15:35:00",
      },
      code: 400,
      error: "Data de início e fim são campos obrigatórios",
    },
    {
      title: "data de fim em branco",
      payload_task: {
        description: "Tarefa para a API nicolasokumabe",
        title: "API nicolasokumabe",
        priority: "ALTA",
        startAt: "2023-11-27T12:30:00",
        endAt: "",
      },
      code: 400,
      error: "Data de início e fim são campos obrigatórios",
    },
    {
      title: "sem o campo descricao",
      payload_task: {
        title: "API nicolasokumabe",
        priority: "ALTA",
        startAt: "2023-11-27T12:30:00",
        endAt: "2023-11-27T15:35:00",
      },
      code: 400,
      error: "Descrição é um campo obrigatório",
    },
    {
      title: "sem o campo titulo",
      payload_task: {
        description: "Tarefa para a API nicolasokumabe",
        priority: "ALTA",
        startAt: "2023-11-27T12:30:00",
        endAt: "2023-11-27T15:35:00",
      },
      code: 400,
      error: "Título é um campo obrigatório",
    },
    {
      title: "sem o campo prioridade",
      payload_task: {
        description: "Tarefa para a API nicolasokumabe",
        title: "API nicolasokumabe",
        startAt: "2023-11-27T12:30:00",
        endAt: "2023-11-27T15:35:00",
      },
      code: 400,
      error: "Prioridade é um campo obrigatório",
    },
    {
      title: "sem o campo data de inicio",
      payload_task: {
        description: "Tarefa para a API nicolasokumabe",
        title: "API nicolasokumabe",
        priority: "ALTA",
        endAt: "2023-11-27T15:35:00",
      },
      code: 400,
      error: "Data de início e fim são campos obrigatórios",
    },
    {
      title: "sem o campo data de fim",
      payload_task: {
        description: "Tarefa para a API nicolasokumabe",
        title: "API nicolasokumabe",
        priority: "ALTA",
        startAt: "2023-11-27T12:30:00",
      },
      code: 400,
      error: "Data de início e fim são campos obrigatórios",
    },
    {
      title: "data antiga",
      payload_task: {
        description: "Tarefa para a API nicolasokumabe",
        title: "API nicolasokumabe",
        priority: "ALTA",
        startAt: "2023-10-27T12:30:00",
        endAt: "2023-10-27T15:35:00",
      },
      code: 400,
      error: "A data de início / data de término deve ser maior que a data atual",
    },
    {
      title: "data invertida",
      payload_task: {
        description: "Tarefa para a API nicolasokumabe",
        title: "API nicolasokumabe",
        priority: "ALTA",
        startAt: "2033-12-27T12:30:00",
        endAt: "2033-11-27T15:35:00",
      },
      code: 400,
      error: "A data de início deve ser menor que a data de término",
    },
  ]

  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Tasks.new.create(e[:payload_task], @payload[:username], @payload[:password])
      end

      it "deve retornar #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end

      it "deve retornar mensagem" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end
