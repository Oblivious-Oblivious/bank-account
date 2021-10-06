describe LoginValidator do
    before(:each) do
        d = DatabaseGateway.new;
        d.reset_database;
        d.store(User.new("oblivious"), "0000", "0000");
    end
    after(:each) { DatabaseGateway.new.reset_database; };

    it "does not fail valid username, pin and password" do
        response = LoginValidator.new.fails?({
            username: "oblivious",
            pin: "0000",
            password: "0000"
        });
        expect(response).to eq false;
    end

    it "fails a login with wrong credentials" do
        response = LoginValidator.new.fails?({
            username: "oblivious",
            pin: "1234",
            password: "pass123"
        });
        expect(response).to eq true;
    end

    it "returns a response model of [:validation_error, \"Log In\"];" do
        expect(LoginValidator.new.response_model.res).to eq :validation_error;
        expect(LoginValidator.new.response_model.use_case).to eq "Log In";
    end

    it "contains an empty :modify_db_state message" do
        expect(LoginValidator.new.modify_db_state({})).to eq nil;
    end
end
