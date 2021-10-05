describe NullLargeAmountValidator do
    before(:each) do
        d = DatabaseGateway.new;
        d.reset_database;
        oblivious = User.new("oblivious");

        d.store(oblivious, "4242", "random42");
        d.add(oblivious, 12);
    end
    after(:each) { DatabaseGateway.new.reset_database; };

    it "fails on any result" do
        expect(NullLargeAmountValidator.new.fails?({})).to eq true;
    end

    it "returns a response model of [:ok, \"Deposit\"]" do
        expect(NullLargeAmountValidator.new.response_model.res).to eq :ok;
        expect(NullLargeAmountValidator.new.response_model.use_case).to eq "Deposit";
    end

    it "deposits an amount and saves transaction objects with correct data" do
        d = DatabaseGateway.new;
        oblivious = User.new("oblivious");

        v = NullLargeAmountValidator.new;
        v.modify_db_state({
            :amount_of => 42,
            :to_user => oblivious
        });

        expect(d.load(oblivious).balance).to eq(54);
        expect(d.load(oblivious).transactions.size).to eq 1;
        expect(d.load(oblivious).transactions[0]["sender"]).to eq oblivious.username;
        expect(d.load(oblivious).transactions[0]["receiver"]).to eq "Bank Account";
        expect(d.load(oblivious).transactions[0]["amount"]).to eq 42;
    end
end
