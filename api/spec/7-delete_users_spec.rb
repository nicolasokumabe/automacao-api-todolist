describe "DELETE /users/delete-user" do
  before(:all) do
    # Criar um novo usuário
    payload = {
      name: "Albert Einstein",
      username: "genius",
      password: "relativity",
    }
    Users.new.create(payload)
  end

  # Cenários de teste
  examples = [
    {
      title: "username errado",
      payload_del: {
        username: "alberto",
        password: "relativity",
      },
      code: 401,
      error: "Credenciais inválidas",
    },
    {
      title: "username em branco",
      payload_del: {
        username: "",
        password: "relativity",
      },
      code: 400,
      error: "Username é um campo obrigatório",
    },
    {
      title: "sem o campo username",
      payload_del: {
        password: "relativity",
      },
      code: 400,
      error: "Username é um campo obrigatório",
    },
    {
      title: "password errada",
      payload_del: {
        username: "genius",
        password: "planet",
      },
      code: 401,
      error: "Credenciais inválidas",
    },
    {
      title: "password em branco",
      payload_del: {
        username: "genius",
        password: "",
      },
      code: 400,
      error: "Senha é um campo obrigatório",
    },
    {
      title: "sem o campo password",
      payload_del: {
        username: "genius",
      },
      code: 400,
      error: "Senha é um campo obrigatório",
    },
  ]

  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Users.new.delete_user(e[:payload_del])
      end

      it "deve retornar #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end

      it "deve retornar mensagem de erro" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end

  context "usuario deletado com sucesso" do
    before(:all) do
      payload_del = {
        username: "genius",
        password: "relativity",
      }
      @result = Users.new.delete_user(payload_del)
    end

    it "valida status code 200" do
      expect(@result.code).to eql 200
    end

    it "valida mensagem de sucesso" do
      expect(@result.parsed_response["message"]).to eql "Usuário deletado com sucesso"
    end
  end
end
