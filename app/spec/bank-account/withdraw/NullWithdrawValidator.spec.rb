describe NullWithdrawValidator do
    before(:each)do
        d = DatabaseGateway.new;
        d.reset_database;
        oblivious = User.new("oblivious");

        d.store(oblivious, "4242", "random42");
        d.add(oblivious, 13);
    end
    after(:each) { DatabaseGateway.new.reset_database; };

    it "fails on any result" do
        expect(NullWithdrawValidator.new.fails?({})).to eq true;
    end

    it "returns a response model of [:ok, \"Withdraw\"]" do
        expect(NullWithdrawValidator.new.response_model.res).to eq :ok;
        expect(NullWithdrawValidator.new.response_model.use_case).to eq "Withdraw";
    end

    it "modifies state by withdrawing a valid amount" do
        d = DatabaseGateway.new;
        oblivious = User.new("oblivious");

        v = NullWithdrawValidator.new;
        v.modify_db_state({
            :amount_of => 8,
            :from_user => oblivious
        });

        expect(d.load(oblivious).balance).to eq 5;
    end
end
