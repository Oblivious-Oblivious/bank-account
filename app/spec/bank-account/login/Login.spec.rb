describe Login do
    before(:each) do
        d = DatabaseGateway.new;
        d.reset_database;
        d.store(User.new("oblivious"), "1234", "pass123");
    end
    after(:each) { DatabaseGateway.new.reset_database; };

    it "responds to the :login message" do
        expect(Login.new).to respond_to(:login);
    end

    it "returns an [:ok, \"Log In\"] array when logged in" do
        l = Login.new;
        response = l.login(
            username: "oblivious",
            pin: "1234",
            password: "pass123"
        );

        expect(response).to eq [:ok, "Log In"];
    end

    it "returns an [:validation_error, \"Log In\"] on invalid credentials" do
        l = Login.new;
        response1 = l.login(
            username: "alice",
            pin: "1234",
            password: "pass123"
        );
        response2 = l.login(
            username: "oblivious",
            pin: "1234",
            password: "1234"
        );
        response3 = l.login(
            username: "oblivious",
            pin: "4242",
            password: "pass1234"
        );

        expect(response1).to eq [:validation_error, "Log In"];
        expect(response2).to eq [:validation_error, "Log In"];
        expect(response3).to eq [:validation_error, "Log In"];
    end
end
