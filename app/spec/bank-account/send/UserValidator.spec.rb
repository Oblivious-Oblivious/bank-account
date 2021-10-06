describe UserValidator do
    before(:each) do
        d = DatabaseGateway.new;
        d.reset_database;
        d.store(User.new("Alice"), "0000", "0000");
        d.store(User.new("Bob"), "0000", "0000");
    end
    after(:each) { DatabaseGateway.new.reset_database; };

    it "does not fail when validating an existing user" do
        expect(UserValidator.new.fails?({
            :from_user => User.new("Alice"),
            :to_user => User.new("Bob")
        })).to eq false;
    end

    it "fails on a non existing user" do
        expect(UserValidator.new.fails?({
            :from_user => User.new("non existent"),
            :to_user => User.new("Bob")
        })).to eq true;
    end

    it "returns a response model of [:hash_id_error, \"Send\"]" do
        expect(UserValidator.new.response_model.res).to eq :hash_id_error;
        expect(UserValidator.new.response_model.use_case).to eq "Send";
    end

    it "contains an empty :modify_db_state message" do
        expect(UserValidator.new.modify_db_state({})).to eq nil;
    end
end
