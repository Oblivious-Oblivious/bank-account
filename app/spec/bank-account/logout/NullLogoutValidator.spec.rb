describe NullLogoutValidator do
    it "fails on any result" do
        expect(NullLogoutValidator.new.fails?({})).to eq true;
    end

    it "returns a response of [:ok, \"Log Out\"]" do
        expect(NullLogoutValidator.new.response_model.res).to eq :ok;
        expect(NullLogoutValidator.new.response_model.use_case).to eq "Log Out";
    end

    it "contains an empty :modify_db_state message" do
        expect(NullLogoutValidator.new.modify_db_state({})).to eq nil;
    end
end
