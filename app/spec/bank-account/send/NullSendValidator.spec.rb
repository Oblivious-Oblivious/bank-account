describe NullSendValidator do
    before(:each) do
        db = DatabaseGateway.new;
        db.reset_database;
        db.store(User.new("Alice"), "1234", "pass123");
        db.store(User.new("Bob"), "9876", "leet987");
        db.add(User.new("Alice"), 42);
        db.add(User.new("Bob"), 37);
    end
    after(:each) { DatabaseGateway.new.reset_database; };

    it "fails on any result" do
        expect(NullSendValidator.new.fails?({})).to eq true;
    end

    it "returns a response model of [:ok, \"Send\"]" do
        expect(NullSendValidator.new.response_model.res).to eq :ok;
        expect(NullSendValidator.new.response_model.use_case).to eq "Send";
    end

    it "modifies state by sending to a valid user" do
        d = DatabaseGateway.new;
        sender = User.new("Alice");
        receiver = User.new("Bob");

        v = NullSendValidator.new;
        v.modify_db_state({
            :amount_of => 13,
            :from_user => sender,
            :to_user => receiver
        });

        expect(d.load(sender).balance).to eq 29;
        expect(d.load(receiver).balance).to eq 50;
    end
end
