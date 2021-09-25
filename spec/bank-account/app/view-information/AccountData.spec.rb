describe AccountData do
    before(:each) do
        @acc = AccountData.new;
    end

    it "returns a representation of the users hash-id" do
        @acc.hash_id = BankHashID.new(username: "oblivious");

        actual = @acc.hash_id.to_s;
        expected = BankHashID.new(username: "oblivious").to_s;

        expect(actual).to eq expected;
    end

    it "returns a representation of the users total amount" do
        @acc.total_amount = 42;

        expect(@acc.total_amount).to eq 42;
    end

    it "returns a representation of the users transaction information" do
        @acc.transaction_information << Transaction.new;
        @acc.transaction_information << Transaction.new;

        expect(@acc.transaction_information.size).to eq 2;
    end
end
