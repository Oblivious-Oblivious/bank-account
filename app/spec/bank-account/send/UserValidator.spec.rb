describe UserValidator do
    before(:each) do
        d = UserSaverGateway.new;
        d.reset_database;
        d.store(User.new("oblivious"), "0000", "0000");
    end

    it "validates an existing user" do
        expect(UserValidator.validate(User.new("oblivious"))).to eq true;
    end

    it "returns false on a non existing user" do
        expect(UserValidator.validate(User.new("non existent"))).to eq false;
    end
end
