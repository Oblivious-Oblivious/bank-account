describe Deposit do
    it "responds to #deposit_amount" do
        expect(Deposit.new).to respond_to :deposit_amount;
    end
end
