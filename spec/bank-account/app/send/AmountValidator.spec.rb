describe AmountValidator do
    before(:each) do
        d = UserSaverGateway.new;
        d.reset_database;
    end

    it "returns true on amount = 42, when balance = 42" do
        d = UserSaverGateway.new;
        oblivious = User.new("oblivious");
        d.store(oblivious, "0000", "0000");
        d.add(oblivious, 42);

        expect(AmountValidator.validate(42, oblivious)).to eq true;
    end

    it "returns false on amount = 42, when balance = 41" do
        d = UserSaverGateway.new;
        oblivious = User.new("oblivious");
        d.store(oblivious, "0000", "0000");
        d.add(oblivious, 41);

        expect(AmountValidator.validate(42, oblivious)).to eq false;
    end

    it "returns false on amount = 1, when balance = 0" do
        d = UserSaverGateway.new;
        oblivious = User.new("oblivious");
        d.store(oblivious, "0000", "0000");
        d.add(oblivious, 0);

        expect(AmountValidator.validate(1, oblivious)).to eq false;
    end

    it "returns false on amount = -42, when balance = 100" do
        d = UserSaverGateway.new;
        oblivious = User.new("oblivious");
        d.store(oblivious, "0000", "0000");
        d.add(oblivious, 100);

        expect(AmountValidator.validate(-42, oblivious)).to eq false;
    end
end
