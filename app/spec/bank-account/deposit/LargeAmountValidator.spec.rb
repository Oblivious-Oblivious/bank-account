describe LargeAmountValidator do
    it "validates true for value=1" do
        expect(LargeAmountValidator.validate(1)).to eq true;
    end

    it "validates false for value=0" do
        expect(LargeAmountValidator.validate(0)).to eq false;
    end

    it "validates false for value=9999" do
        expect(LargeAmountValidator.validate(9999)).to eq true;
    end

    it "validates false for value=10000" do
        expect(LargeAmountValidator.validate(10000)).to eq false;
    end
end
