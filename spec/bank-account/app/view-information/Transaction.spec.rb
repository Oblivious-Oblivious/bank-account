def _create_transaction(s, r)
    t = Transaction.new;
    t.create(sender: s, receiver: r);
    t;
end

describe Transaction do
    it "initializes with a nil transaction id of ['id']" do
        expect(Transaction.new.tid).to eq("id");
    end

    it "initializes with a (sender,receiver,date) of ('','',DateModel.new)" do
        t = Transaction.new;
        
        expect(t.tid).to eq "id";
        expect(t.sender).to eq "";
        expect(t.receiver).to eq "";
        expect(t.date).to eq nil;
    end

    it "fills new data in when creating a new transaction" do
        t = _create_transaction("bank", "oblivious");

        expect(t.sender).to eq "bank";
        expect(t.receiver).to eq "oblivious";
    end

    it "creates a new transaction with input data" do
        t = _create_transaction("alice", "bob");

        expect(t.tid).to eq "6b46bf072ec7f0c47b963534587b307eddbd3715173a00be901e1ae81bb8cac59e8007723058c3b43415a70bf0d9f6483b2da0b17d8f7d70faa5c440073c45da";
    end

    it "makes sure that the date recorded is the latest possible" do
        t = _create_transaction("bank", "oblivious");
        sleep(0.001); # Simulate a delay
        newer_date = DateModel.new;

        expect(t.date < newer_date).to eq true;
    end
end
