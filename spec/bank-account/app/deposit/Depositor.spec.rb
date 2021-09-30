def setup_mock_db_data
    d = UserSaverGateway.new;
    d.reset_database;
    oblivious = User.new("oblivious");

    d.store(oblivious, "4242", "random42");
    d.add(oblivious, 12);

    d;
end

describe Depositor do
    it "responds to the :deposit message" do
        expect(Depositor.new).to respond_to(:deposit);
    end

    it "deposits a valid amount of $42 to a new user" do
        d = setup_mock_db_data;
        oblivious = User.new("oblivious");
        
        dep = Depositor.new;
        dep.deposit(amount_of: 42, to_user: oblivious);

        expect(d.load_all_users["users"]["oblivious"].balance).to eq(54);
    end

    it "deposits an invalid amount of $10000 to a new user" do
        d = setup_mock_db_data;
        oblivious = User.new("oblivious");
        
        dep = Depositor.new;
        dep.deposit(amount_of: 10_000, to_user: oblivious);

        expect(d.load_all_users["users"]["oblivious"].balance).to eq(12);
    end
end
