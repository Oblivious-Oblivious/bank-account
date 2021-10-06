describe Register do
    before(:each) { DatabaseGateway.new.reset_database; };
    after(:each) { DatabaseGateway.new.reset_database; };

    it "responds to the :register message" do
        expect(Register.new).to respond_to(:register);
    end

    it "returns an [:ok, \"Register\"] array when successfully registered" do
        r = Register.new;
        model = RequestModel.new(vals: [
            DuplicationValidator.new,
            NullDuplicationValidator.new
        ], data: {
            :username => "oblivious",
            :pin => "1234",
            :password => "pass123"
        });
        response = r.register(request_model: model);

        expect(response.res).to eq :ok;
        expect(response.use_case).to eq "Register";
    end

    it "makes sure the user is saved on successfull register" do
        r = Register.new;
        model = RequestModel.new(vals: [
            DuplicationValidator.new,
            NullDuplicationValidator.new
        ], data: {
            :username => "alice",
            :pin => "0000",
            :password => "4l1c3 l3373r"
        });
        response = r.register(request_model: model);

        d = DatabaseGateway.new;
        alice = d.load(User.new("alice"));

        expect(response.res).to eq :ok;
        expect(response.use_case).to eq "Register";
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
        model = RequestModel.new(vals: [
            DuplicationValidator.new,
            NullDuplicationValidator.new
        ], data: {
            :username => "oblivious",
            :pin => "1234",
            :password => "pass123"
        });
        response = r.register(request_model: model);

        oblivious = d.load(User.new("oblivious"));
        expect(response.res).to eq :duplication_error;
        expect(response.use_case).to eq "Register";
        expect(d.load_all_users["users"].size).to eq 1;
        expect(oblivious.username).to eq "oblivious";
        expect(oblivious.balance).to eq 0;
        expect(oblivious.pin).to eq "0000";
        expect(oblivious.password).to eq "0000";
    end

    it "tries to register a user twice but only does so once" do
        r = Register.new;

        r = Register.new;
        model = RequestModel.new(vals: [
            DuplicationValidator.new,
            NullDuplicationValidator.new
        ], data: {
            :username => "oblivious",
            :pin => "1234",
            :password => "pass123"
        });
        response1 = r.register(request_model: model);
        response2 = r.register(request_model: model);

        d = DatabaseGateway.new;
        oblivious = d.load(User.new("oblivious"));

        expect(response1.res).to eq :ok;
        expect(response1.use_case).to eq "Register";
        expect(response2.res).to eq :duplication_error;
        expect(response2.use_case).to eq "Register";
        expect(d.load_all_users["users"].size).to eq 1;
        expect(oblivious.username).to eq "oblivious";
        expect(oblivious.balance).to eq 0;
        expect(oblivious.pin).to eq "1234";
        expect(oblivious.password).to eq "pass123";
    end
end
