describe "GET /tasks" do
  context "obter tarefas" do
    before(:all) do
      @result = Tasks.new.find_by_taks()
    end

    it "valida status code 200" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuário" do
      expect(@result.parsed_response["id"].length).to eql 36
    end
  end
end
