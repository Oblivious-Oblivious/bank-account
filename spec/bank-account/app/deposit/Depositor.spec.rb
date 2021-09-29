describe Depositor do
    it "responds to the :deposit message" do
        expect(Depositor.new).to respond_to(:deposit);
    end
end
