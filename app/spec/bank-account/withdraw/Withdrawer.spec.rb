describe Withdrawer do
    before :each do
        d = DatabaseGateway.new;
        d.reset_database;
        oblivious = User.new("oblivious");

        d.store(oblivious, "4242", "random42");
        d.add(oblivious, 13);
    end

    it "responds to the :withdraw message" do
        expect(Withdrawer.new).to respond_to(:withdraw);
    end

    it "tries to deposit an invalid amount" do
        d = DatabaseGateway.new;
        oblivious = User.new("oblivious");

        w = Withdrawer.new;
        response = w.withdraw(amount_of: 42, from_user: oblivious);

        expect(response).to eq [:validation_error, "Withdraw"];
        expect(d.load(oblivious).balance).to eq 13;
    end

    it "withdraws a valid amount" do
        d = DatabaseGateway.new;
        oblivious = User.new("oblivious");

        w = Withdrawer.new;
        response = w.withdraw(amount_of: 8, from_user: oblivious);

        expect(response).to eq [:ok, "Withdraw"];
        expect(d.load(oblivious).balance).to eq 5;
    end
end
