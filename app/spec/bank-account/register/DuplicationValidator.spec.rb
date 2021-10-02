describe DuplicationValidator do
    before(:each) do
        d = UserSaverGateway.new;
        d.reset_database;
    end

    it "validates a valid username that does not exist" do
        response = DuplicationValidator.validate("oblivious");

        expect(response).to eq true;
    end

    # TODO Register validation
end
