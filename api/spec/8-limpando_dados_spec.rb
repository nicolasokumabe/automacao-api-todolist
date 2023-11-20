describe "Limpando Dados" do
  examples = [
    {
      title: "deletando Nicolas Kumabe",
      payload_del: {
        username: "nicolasokumabe",
        password: "pwd123",
      },
    },
    {
      title: "deletando Roger Guedes",
      payload_del: {
        username: "arabia",
        password: "coringa123",
      },
    },
    {
      title: "deletando Caps Lock",
      payload_del: {
        username: "capsulado",
        password: "123456",
      },
    },
    {
      title: "deletando Tom Mate",
      payload_del: {
        username: "tomate",
        password: "pwd123",
      },
    },
    {
      title: "deletando Chris Bumstead",
      payload_del: {
        username: "CBUM",
        password: "meteor",
      },
    },
    {
      title: "deletando Ramon R Q",
      payload_del: {
        username: "dino",
        password: "#Superforearms2024champion",
      },
    },
    {
      title: "deletando Jude Bellingham",
      payload_del: {
        username: "bellinghol",
        password: "#Oiluminado",
      },
    },
    {
      title: "deletando Vinícius Júnior",
      payload_del: {
        username: "vinijr",
        password: "Camisa7",
      },
    },
  ]

  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Users.new.delete_user(e[:payload_del])
      end

      it "deve retornar 200" do
        expect(@result.code).to eql 200
      end

      it "deve retornar mensagem de erro" do
        expect(@result.parsed_response["message"]).to eql "Usuário deletado com sucesso"
      end
    end
  end
end
