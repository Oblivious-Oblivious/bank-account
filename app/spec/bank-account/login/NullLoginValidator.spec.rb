describe NullLoginValidator do
    before(:each) do
        d = DatabaseGateway.new;
        d.reset_database;
        d.store(User.new("oblivious"), "0000", "0000");
    end
    after(:each) { DatabaseGateway.new.reset_database; };

    it "fails on any result" do
        expect(NullLoginValidator.new.fails?({})).to eq true;
    end

    it "returns a response model of [:ok, \"Log In\"]" do
        expect(NullLoginValidator.new.response_model.res).to eq :ok;
        expect(NullLoginValidator.new.response_model.use_case).to eq "Log In";
    end

    it "contains an empty :modify_db_state message" do
        expect(NullLoginValidator.new.modify_db_state({})).to eq nil;
    end
end
