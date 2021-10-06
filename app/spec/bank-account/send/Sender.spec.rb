describe Sender do
    before(:each) do
        db = DatabaseGateway.new;
        db.reset_database;
        db.store(User.new("Alice"), "1234", "pass123");
        db.store(User.new("Bob"), "9876", "leet987");
        db.add(User.new("Alice"), 42);
        db.add(User.new("Bob"), 37);
    end
    after(:each) { DatabaseGateway.new.reset_database; };

    it "responds to the :send message" do
        expect(Sender.new).to respond_to(:send);
    end

    it "tries to send to an invalid user" do
        d = DatabaseGateway.new;
        sender = User.new("Alice");
        receiver = User.new("Non existent");

        s = Sender.new;
        model = RequestModel.new(vals: [
            AmountValidator.new,
            UserValidator.new,
            NullSendValidator.new
        ], data: {
            :amount_of => 13,
            :from_user => sender,
            :to_user => receiver
        });
        response = s.send(request_model: model);

        expect(response.res).to eq :hash_id_error;
        expect(response.use_case).to eq "Send";
        expect(d.load(sender).balance).to eq 42;
    end

    it "sends to a valid user" do
        d = DatabaseGateway.new;
        sender = User.new("Alice");
        receiver = User.new("Bob");
        
        s = Sender.new;
        model = RequestModel.new(vals: [
            AmountValidator.new,
            UserValidator.new,
            NullSendValidator.new
        ], data: {
            :amount_of => 13,
            :from_user => sender,
            :to_user => receiver
        });
        response = s.send(request_model: model);

        expect(response.res).to eq :ok;
        expect(response.use_case).to eq "Send";
        expect(d.load(sender).balance).to eq 29;
        expect(d.load(receiver).balance).to eq 50;
    end

    it "tries to send an invalid amount" do
        d = DatabaseGateway.new;
        sender = User.new("Alice");
        receiver = User.new("Bob");
        
        s = Sender.new;
        model = RequestModel.new(vals: [
            AmountValidator.new,
            UserValidator.new,
            NullSendValidator.new
        ], data: {
            :amount_of => 113,
            :from_user => sender,
            :to_user => receiver
        });
        response = s.send(request_model: model);

        expect(response.res).to eq :amount_error;
        expect(response.use_case).to eq "Send";
        expect(DatabaseGateway.new.load(sender).balance).to eq 42;
        expect(DatabaseGateway.new.load(receiver).balance).to eq 37;
    end

    it "tries to send a negative amount" do
        d = DatabaseGateway.new;
        sender = User.new("Alice");
        receiver = User.new("Bob");
        
        s = Sender.new;
        model = RequestModel.new(vals: [
            AmountValidator.new,
            UserValidator.new,
            NullSendValidator.new
        ], data: {
            :amount_of => -113,
            :from_user => sender,
            :to_user => receiver
        });
        response = s.send(request_model: model);

        expect(response.res).to eq :amount_error;
        expect(response.use_case).to eq "Send";
        expect(DatabaseGateway.new.load(sender).balance).to eq 42;
        expect(DatabaseGateway.new.load(receiver).balance).to eq 37;
    end

    it "saves a transaction object for each user after each send" do
        d = DatabaseGateway.new;
        sender = User.new("Alice");
        receiver = User.new("Bob");
        
        s = Sender.new;
        model = RequestModel.new(vals: [
            AmountValidator.new,
            UserValidator.new,
            NullSendValidator.new
        ], data: {
            :amount_of => 13,
            :from_user => sender,
            :to_user => receiver
        });
        response = s.send(request_model: model);

        expect(d.load(sender).transactions.size).to eq 1;
        expect(d.load(receiver).transactions.size).to eq 1;
    end

    it "saves transaction objects with correct data" do
        d = DatabaseGateway.new;
        sender = User.new("Alice");
        receiver = User.new("Bob");
        
        s = Sender.new;
        model = RequestModel.new(vals: [
            AmountValidator.new,
            UserValidator.new,
            NullSendValidator.new
        ], data: {
            :amount_of => 13,
            :from_user => sender,
            :to_user => receiver
        });
        response = s.send(request_model: model);

        expect(d.load(sender).transactions[0]["sender"]).to eq sender.username;
        expect(d.load(sender).transactions[0]["receiver"]).to eq receiver.username;
        expect(d.load(sender).transactions[0]["amount"]).to eq 13;
        expect(d.load(receiver).transactions[0]["sender"]).to eq sender.username;
        expect(d.load(receiver).transactions[0]["receiver"]).to eq receiver.username;
        expect(d.load(receiver).transactions[0]["amount"]).to eq 13;
    end
end
