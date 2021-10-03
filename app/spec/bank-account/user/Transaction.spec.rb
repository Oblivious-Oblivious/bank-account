describe Transaction do
    it "stores the name of the sender and receiver" do
        t = Transaction.new(
            sender: User.new("alice"),
            receiver: User.new("bob"),
            amount: 42
        );

        expect(t.sender).to eq("alice");
        expect(t.receiver).to eq("bob");
    end

    it "stores the amount of the transaction" do
        t = Transaction.new(
            sender: User.new("alice"),
            receiver: User.new("bob"),
            amount: 42
        );

        expect(t.amount).to eq 42;
    end

    it "stores the date of the transaction" do
        t = Transaction.new(
            sender: User.new("alice"),
            receiver: User.new("bob"),
            amount: 42
        );

        expect(t.date).to be_a Time;
    end

    it "compares two transactions for equality based sender/receiver/amount" do
        t1 = Transaction.new(
            sender: User.new("alice"),
            receiver: User.new("bob"),
            amount: 42
        );
        t2 = Transaction.new(
            sender: User.new("alice"),
            receiver: User.new("bob"),
            amount: 42
        );

        expect(t1).to eq t2;
    end
end
