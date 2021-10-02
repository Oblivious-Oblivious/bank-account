describe LoginValidator do
    before(:each) do
        d = DatabaseGateway.new;
        d.reset_database;
        d.store(User.new("oblivious"), "0000", "0000");
    end
    after(:each) { DatabaseGateway.new.reset_database; };

    it "validates valid username, pin and password" do
        response = LoginValidator.validate("oblivious", "0000", "0000");
        expect(response).to eq true;
    end

    it "rejects a login with wrong credentials" do
        response = LoginValidator.validate("oblivious", "1234", "pass123");
        expect(response).to eq false;
    end
end
