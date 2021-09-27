describe Depositor do
    it "responds to #deposit_amount" do
        expect(Depositor.new).to respond_to :deposit_amount;
    end
end
