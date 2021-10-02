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
        s = Sender.new;
        sender = User.new("Alice");
        receiver = User.new("Non existent");

        response = s.send(
            amount_of: 13,
            from_user: sender,
            to_user: receiver
        );

        expect(response).to eq [:hash_id_error, "Send"];
        expect(DatabaseGateway.new.load(sender).balance).to eq 42;
    end

    it "sends to a valid user" do
        s = Sender.new;
        sender = User.new("Alice");
        receiver = User.new("Bob");

        response = s.send(
            amount_of: 13,
            from_user: sender,
            to_user: receiver
        );

        expect(response).to eq [:ok, "Send"];
        expect(DatabaseGateway.new.load(sender).balance).to eq 29;
        expect(DatabaseGateway.new.load(receiver).balance).to eq 50;
    end

    it "tries to send an invalid amount" do
        s = Sender.new;
        sender = User.new("Alice");
        receiver = User.new("Bob");

        response = s.send(
            amount_of: 113,
            from_user: sender,
            to_user: receiver
        );

        expect(response).to eq [:amount_error, "Send"];
        expect(DatabaseGateway.new.load(sender).balance).to eq 42;
        expect(DatabaseGateway.new.load(receiver).balance).to eq 37;
    end

    it "tries to send a negative amount" do
        s = Sender.new;
        sender = User.new("Alice");
        receiver = User.new("Bob");

        response = s.send(
            amount_of: -113,
            from_user: sender,
            to_user: receiver
        );

        expect(response).to eq [:amount_error, "Send"];
        expect(DatabaseGateway.new.load(sender).balance).to eq 42;
        expect(DatabaseGateway.new.load(receiver).balance).to eq 37;
    end
end
