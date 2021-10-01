def setup_mock_db_data
    d = UserSaverGateway.new;
    d.reset_database;
    oblivious = User.new("oblivious");

    d.store(oblivious, "4242", "random42");
    d.add(oblivious, 13);

    d;
end

describe Withdrawer do
    it "responds to the :withdraw message" do
        expect(Withdrawer.new).to respond_to(:withdraw);
    end

    it "tries to deposit an invalid amount" do
        d = setup_mock_db_data;
        oblivious = User.new("oblivious");

        w = Withdrawer.new;
        response = w.withdraw(amount_of: 42, from_user: oblivious);

        expect(response).to eq [:validation_error, "Withdraw"];
        expect(d.load(oblivious).balance).to eq 13;
    end
end
