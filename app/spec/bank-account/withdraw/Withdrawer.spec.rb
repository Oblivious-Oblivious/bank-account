describe Withdrawer do
    before(:each)do
        d = DatabaseGateway.new;
        d.reset_database;
        oblivious = User.new("oblivious");

        d.store(oblivious, "4242", "random42");
        d.add(oblivious, 13);
    end
    after(:each) { DatabaseGateway.new.reset_database; };

    it "responds to the :withdraw message" do
        expect(Withdrawer.new).to respond_to(:withdraw);
    end

    it "tries to deposit an invalid amount" do
        d = DatabaseGateway.new;
        oblivious = User.new("oblivious");

        w = Withdrawer.new;
        model = RequestModel.new(vals: [
            WithdrawValidator.new,
            NullWithdrawValidator.new
        ], data: {
            :amount_of => 42,
            :from_user => oblivious
        });
        response = w.withdraw(request_model: model);

        expect(response.res).to eq :amount_error;
        expect(response.use_case).to eq "Withdraw";
        expect(d.load(oblivious).balance).to eq 13;
    end

    it "withdraws a valid amount" do
        d = DatabaseGateway.new;
        oblivious = User.new("oblivious");

        w = Withdrawer.new;
        model = RequestModel.new(vals: [
            WithdrawValidator.new,
            NullWithdrawValidator.new
        ], data: {
            :amount_of => 8,
            :from_user => oblivious
        });
        response = w.withdraw(request_model: model);

        expect(response.res).to eq :ok;
        expect(response.use_case).to eq "Withdraw";
        expect(d.load(oblivious).balance).to eq 5;
    end

    it "saves a transaction object after each withdraw" do
        d = DatabaseGateway.new;
        oblivious = User.new("oblivious");

        w = Withdrawer.new;
        model = RequestModel.new(vals: [
            WithdrawValidator.new,
            NullWithdrawValidator.new
        ], data: {
            :amount_of => 8,
            :from_user => oblivious
        });
        response = w.withdraw(request_model: model);

        expect(d.load(oblivious).transactions.size).to eq 1;
    end

    it "saves transaction objects with correct data" do
        d = DatabaseGateway.new;
        oblivious = User.new("oblivious");

        w = Withdrawer.new;
        model = RequestModel.new(vals: [
            WithdrawValidator.new,
            NullWithdrawValidator.new
        ], data: {
            :amount_of => 8,
            :from_user => oblivious
        });
        response = w.withdraw(request_model: model);

        expect(d.load(oblivious).transactions[0]["sender"]).to eq "Bank Account";
        expect(d.load(oblivious).transactions[0]["receiver"]).to eq oblivious.username;
        expect(d.load(oblivious).transactions[0]["amount"]).to eq 8;
    end
end
