describe NullDuplicationValidator do
    before(:each) do
        d = DatabaseGateway.new;
        d.reset_database;
    end
    after(:each) { DatabaseGateway.new.reset_database; };

    it "fails on any result" do
        expect(NullDuplicationValidator.new.fails?({})).to eq true;
    end

    it "returns a response model of [:ok, \"Register\"]" do
        expect(NullDuplicationValidator.new.response_model.res).to eq :ok;
        expect(NullDuplicationValidator.new.response_model.use_case).to eq "Register";
    end

    it "saves the user on successfull register" do
        v = NullDuplicationValidator.new;
        v.modify_db_state({
            :username => "alice",
            :pin => "0000",
            :password => "4l1c3 l3373r"
        });

        d = DatabaseGateway.new;
        alice = d.load(User.new("alice"));

        expect(d.load_all_users["users"].size).to eq 1;
        expect(alice.username).to eq "alice";
        expect(alice.balance).to eq 0;
        expect(alice.pin).to eq "0000";
        expect(alice.password).to eq "4l1c3 l3373r";
    end
end
