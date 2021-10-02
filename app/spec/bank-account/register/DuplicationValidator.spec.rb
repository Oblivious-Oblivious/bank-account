describe DuplicationValidator do
    before(:each) do
        d = DatabaseGateway.new;
        d.reset_database;
    end
    after(:each) { DatabaseGateway.new.reset_database; };

    it "validates a valid username that does not exist" do
        response = DuplicationValidator.validate("oblivious");
        expect(response).to eq true;
    end

    it "rejects a registration with an existing username" do
        d = DatabaseGateway.new;
        d.store(User.new("oblivious"), "0000", "0000");

        response = DuplicationValidator.validate("oblivious");
        expect(response).to eq false;
    end
end
