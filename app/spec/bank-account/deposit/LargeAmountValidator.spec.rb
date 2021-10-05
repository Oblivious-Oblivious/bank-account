describe LargeAmountValidator do
    it "fails false for value=1" do
        expect(LargeAmountValidator.new.fails?({:amount_of => 1})).to eq false;
    end

    it "fails true for value=0" do
        expect(LargeAmountValidator.new.fails?({:amount_of => 0})).to eq true;
    end

    it "fails false for value=9999" do
        expect(LargeAmountValidator.new.fails?({:amount_of => 9999})).to eq false;
    end

    it "fails true for value=10000" do
        expect(LargeAmountValidator.new.fails?({:amount_of => 10000})).to eq true;
    end

    it "returns a response model of [:large_amount_error, \"Deposit\"]" do
        expect(LargeAmountValidator.new.response_model.res).to eq :large_amount_error;
        expect(LargeAmountValidator.new.response_model.use_case).to eq "Deposit";
    end

    it "contains an empty :modify_db_state message" do
        expect(LargeAmountValidator.new.modify_db_state({})).to eq nil;
    end
end
