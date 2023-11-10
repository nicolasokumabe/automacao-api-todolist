describe "PATCH /users/change-password" do
  before(:all) do
    # Criar um novo usuário
    @payload = {
      name: "Ramon R Q",
      username: "dino",
      password: "forearms",
    }
    Users.new.create(@payload)
  end

  context "senha trocada com sucesso" do
    before(:all) do
      payload_new_pass = {
        username: "dino",
        currentPassword: "forearms",
        newPassword: "#Superforearms2024champion",
      }
      @result = Users.new.change_pass(payload_new_pass)
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida mensagem de sucesso" do
      expect(@result.parsed_response["message"]).to eql "Senha alterada com sucesso"
    end
  end

  examples = [
    {
      title: "username errado",
      payload_new_pass: {
        username: "dinossauro",
        currentPassword: "#Superforearms2024champion",
        newPassword: "forearms",
      },
      code: 401,
      error: "Credenciais inválidas",
    },
    {
      title: "username em branco",
      payload_new_pass: {
        username: "",
        currentPassword: "#Superforearms2024champion",
        newPassword: "forearms",
      },
      code: 401,
      error: "Credenciais inválidas",
    },
    {
      title: "sem o campo username",
      payload_new_pass: {
        currentPassword: "#Superforearms2024champion",
        newPassword: "forearms",
      },
      code: 401,
      error: "Credenciais inválidas",
    },
    {
      title: "senha atual errada",
      payload_new_pass: {
        username: "dino",
        currentPassword: "antibraco",
        newPassword: "forearms",
      },
      code: 401,
      error: "Credenciais inválidas",
    },
    {
      title: "senha atual em branco",
      payload_new_pass: {
        username: "dino",
        currentPassword: "",
        newPassword: "forearms",
      },
      code: 400,
      error: "A senha atual deve ser fornecida",
    },
    {
      title: "sem o campo senha atual",
      payload_new_pass: {
        username: "dino",
        newPassword: "forearms",
      },
      code: 400,
      error: "A senha atual deve ser fornecida",
    },
    {
      title: "senha nova em branco",
      payload_new_pass: {
        username: "dino",
        currentPassword: "#Superforearms2024champion",
        newPassword: "",
      },
      code: 400,
      error: "A nova senha não pode ser vazia",
    },
    {
      title: "senha nova com menos de 6 caracteres",
      payload_new_pass: {
        username: "dino",
        currentPassword: "#Superforearms2024champion",
        newPassword: "braco",
      },
      code: 400,
      error: "A nova senha deve ter pelo menos 6 caracteres",
    },
    {
      title: "senha nova igual a senha atual",
      payload_new_pass: {
        username: "dino",
        currentPassword: "#Superforearms2024champion",
        newPassword: "#Superforearms2024champion",
      },
      code: 400,
      error: "A nova senha não pode ser igual à senha atual",
    },
  ]

  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Users.new.change_pass(e[:payload_new_pass])
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
