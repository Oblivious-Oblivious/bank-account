describe RequestModel do
    it "contains a data hash to be passed into the control object" do
        rm = RequestModel.new(vals: [], data: {
            :amount_of => 42,
            :from_user => User.new("alice"),
            :to_user => User.new("bob")
        });

        expect(rm.data.size).to eq 3;
        expect(rm.data[:amount_of]).to eq 42;
        expect(rm.data[:from_user]).to eq User.new("alice");
        expect(rm.data[:to_user].username).to eq "bob";
    end

    it "contains a vals array describing the validator objects" do
        rm = RequestModel.new(vals: [AmountValidator, UserValidator], data: {});

        expect(rm.vals.size).to eq 2;
        expect(rm.vals[0]).to be(AmountValidator);
        expect(rm.vals[1]).to be(UserValidator);
    end

    it "presents itself in string mode" do
        rm = RequestModel.new(vals: [AmountValidator, UserValidator], data: {
            :amount_of => 42,
            :from_user => User.new("alice"),
            :to_user => User.new("bob")
        });

        expect(rm.to_s).to eq "[[AmountValidator, UserValidator],[:amount_of, :from_user, :to_user]]";
    end

    it "compares two response models by `vals` and `data`" do
        rm1 = RequestModel.new(vals: [AmountValidator, UserValidator], data: {
            :amount_of => 42,
            :from_user => User.new("alice"),
            :to_user => User.new("bob")
        });
        rm2 = RequestModel.new(vals: [AmountValidator, UserValidator], data: {
            :amount_of => 42,
            :from_user => User.new("alice"),
            :to_user => User.new("bob")
        });

        expect(rm1).to eq rm2;
    end
end
