describe AmountValidator do
    before(:each) do
        d = DatabaseGateway.new;
        d.reset_database;
    end
    after(:each) { DatabaseGateway.new.reset_database; };

    it "does not fail on amount = 42, when balance = 42" do
        d = DatabaseGateway.new;
        oblivious = User.new("oblivious");
        d.store(oblivious, "0000", "0000");
        d.add(oblivious, 42);

        expect(AmountValidator.new.fails?({:amount_of => 42, :from_user => oblivious})).to eq false;
    end

    it "fails on amount = 42, when balance = 41" do
        d = DatabaseGateway.new;
        oblivious = User.new("oblivious");
        d.store(oblivious, "0000", "0000");
        d.add(oblivious, 41);

        expect(AmountValidator.new.fails?({:amount_of => 42, :from_user => oblivious})).to eq true;
    end

    it "fails on amount = 1, when balance = 0" do
        d = DatabaseGateway.new;
        oblivious = User.new("oblivious");
        d.store(oblivious, "0000", "0000");
        d.add(oblivious, 0);

        expect(AmountValidator.new.fails?({:amount_of => 1, :from_user => oblivious})).to eq true;
    end

    it "fails on amount = -42, when balance = 100" do
        d = DatabaseGateway.new;
        oblivious = User.new("oblivious");
        d.store(oblivious, "0000", "0000");
        d.add(oblivious, 100);

        expect(AmountValidator.new.fails?({:amount_of => -42, :from_user => oblivious})).to eq true;
    end

    it "returns a response model of [:amount_error, \"Send\"]" do
        expect(AmountValidator.new.response_model.res).to eq :amount_error;
        expect(AmountValidator.new.response_model.use_case).to eq "Send";
    end

    it "contains an empty :modify_db_state message" do
        expect(AmountValidator.new.modify_db_state({})).to eq nil;
    end
end
