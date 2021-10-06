describe Logout do
    it "responds to the :logout message" do
        expect(Logout.new).to respond_to(:logout);
    end

    it "returns [:ok, \"Log Out\"] when :logout is called" do
        model = RequestModel.new(vals: [
            NullLogoutValidator.new
        ], data: {
            user: User.new("oblivious")
        });

        response = Logout.new.logout(request_model: model);
        expect(response.res).to eq :ok;
        expect(response.use_case).to eq "Log Out";
    end
end
