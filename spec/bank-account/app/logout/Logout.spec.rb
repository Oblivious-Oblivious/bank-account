describe Logout do
    it "responds to the :logout message" do
        expect(Logout.new).to respond_to(:logout);
    end

    it "returns [:ok, \"Log Out\"] when :logout is called" do
        obj = Logout.new.logout(user: User.new("oblivious"));
        expect(obj).to eq [:ok, "Log Out"];
    end
end
