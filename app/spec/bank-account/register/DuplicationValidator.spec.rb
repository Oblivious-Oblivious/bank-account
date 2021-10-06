describe DuplicationValidator do
    before(:each) do
        d = DatabaseGateway.new;
        d.reset_database;
    end
    after(:each) { DatabaseGateway.new.reset_database; };

    it "does not fail on a valid username that does not exist" do
        response = DuplicationValidator.new.fails?({:username => "oblivious"});
        expect(response).to eq false;
    end

    it "fails a registration with an existing username" do
        d = DatabaseGateway.new;
        d.store(User.new("oblivious"), "0000", "0000");

        response = DuplicationValidator.new.fails?({:username => "oblivious"});
        expect(response).to eq true;
    end

    it "returns a response model of [:duplication_error, \"Register\"]" do
        expect(DuplicationValidator.new.response_model.res).to eq :duplication_error;
        expect(DuplicationValidator.new.response_model.use_case).to eq "Register";
    end

    it "contains an empty :modify_db_state message" do
        expect(DuplicationValidator.new.modify_db_state({})).to eq nil;
    end
end
