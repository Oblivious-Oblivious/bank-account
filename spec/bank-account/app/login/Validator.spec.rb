describe LoginValidator do
    it "validates valid username, pin and password" do
        response = LoginValidator.validate("oblivious", 1234, "pass123");

        expect(response).to eq true;
    end
end
