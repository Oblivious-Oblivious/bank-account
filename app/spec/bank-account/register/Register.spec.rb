describe Register do
    before(:each) { DatabaseGateway.new.reset_database; };
    after(:each) { DatabaseGateway.new.reset_database; };

    it "responds to the :register message" do
        expect(Register.new).to respond_to(:register);
    end

    it "returns an [:ok, \"Register\"] array when successfully registered" do
        r = Register.new;
        response = r.register(
            username: "oblivious",
            pin: "1234",
            password: "pass123"
        );

        expect(response).to eq [:ok, "Register"];
    end

    it "makes sure the user is saved on successfull register" do
        r = Register.new;
        response = r.register(
            username: "alice",
            pin: "0000",
            password: "4l1c3 l3373r"
        );

        d = DatabaseGateway.new;
        alice = d.load(User.new("alice"));

        expect(response).to eq [:ok, "Register"];
        expect(d.load_all_users["users"].size).to eq 1;
        expect(alice.username).to eq "alice";
        expect(alice.balance).to eq 0;
        expect(alice.pin).to eq "0000";
        expect(alice.password).to eq "4l1c3 l3373r";
    end

    it "returns an [:duplication_error, \"Register\"] on existing credentials" do
        d = DatabaseGateway.new;
        d.store(User.new("oblivious"), "0000", "0000");

        r = Register.new;
        response = r.register(
            username: "oblivious",
            pin: "1234",
            password: "pass123"
        );

        oblivious = d.load(User.new("oblivious"));

        expect(response).to eq [:duplication_error, "Register"];
        expect(d.load_all_users["users"].size).to eq 1;
        expect(oblivious.username).to eq "oblivious";
        expect(oblivious.balance).to eq 0;
        expect(oblivious.pin).to eq "0000";
        expect(oblivious.password).to eq "0000";
    end

    it "tries to register a user twice but only does so once" do
        r = Register.new;

        response1 = r.register(
            username: "oblivious",
            pin: "1234",
            password: "pass123"
        );
        response2 = r.register(
            username: "oblivious",
            pin: "1234",
            password: "pass123"
        );

        d = DatabaseGateway.new;
        oblivious = d.load(User.new("oblivious"));

        expect(response1).to eq [:ok, "Register"];
        expect(response2).to eq [:duplication_error, "Register"];
        expect(d.load_all_users["users"].size).to eq 1;
        expect(oblivious.username).to eq "oblivious";
        expect(oblivious.balance).to eq 0;
        expect(oblivious.pin).to eq "1234";
        expect(oblivious.password).to eq "pass123";
    end
end
