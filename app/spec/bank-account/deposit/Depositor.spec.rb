describe Depositor do
    before :each do
        d = DatabaseGateway.new;
        d.reset_database;
        oblivious = User.new("oblivious");

        d.store(oblivious, "4242", "random42");
        d.add(oblivious, 12);

        d;
    end
    after(:each) { DatabaseGateway.new.reset_database; };

    it "responds to the :deposit message" do
        expect(Depositor.new).to respond_to(:deposit);
    end

    it "deposits a valid amount of $42 to a new user" do
        d = DatabaseGateway.new;
        oblivious = User.new("oblivious");
        
        dep = Depositor.new;
        response = dep.deposit(amount_of: 42, to_user: oblivious);

        expect(d.load_all_users["users"]["oblivious"].balance).to eq(54);
        expect(response).to eq [:ok, "Deposit"];
    end

    it "deposits an invalid amount of $10000 to a new user" do
        d = DatabaseGateway.new;
        oblivious = User.new("oblivious");
        
        dep = Depositor.new;
        response = dep.deposit(amount_of: 10_000, to_user: oblivious);

        expect(d.load_all_users["users"]["oblivious"].balance).to eq(12);
        expect(response).to eq [:large_amount_error, "Deposit"];
    end

    it "saves a transaction object after each deposit" do
        d = DatabaseGateway.new;
        oblivious = User.new("oblivious");

        dep = Depositor.new;
        response = dep.deposit(amount_of: 42, to_user: oblivious);

        expect(d.load(oblivious).transactions.size).to eq 1;
    end

    it "saves transaction objects with correct data" do
        d = DatabaseGateway.new;
        oblivious = User.new("oblivious");

        dep = Depositor.new;
        response = dep.deposit(amount_of: 42, to_user: oblivious);

        expect(d.load(oblivious).transactions[0]["sender"]).to eq oblivious.username;
        expect(d.load(oblivious).transactions[0]["receiver"]).to eq "Bank Account";
        expect(d.load(oblivious).transactions[0]["amount"]).to eq 42;
    end
end
