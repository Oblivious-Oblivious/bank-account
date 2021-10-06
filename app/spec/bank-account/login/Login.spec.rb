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
        model = RequestModel.new(vals: [
            LoginValidator.new,
            NullLoginValidator.new
        ], data: {
            :username => "oblivious",
            :pin => "1234",
            :password => "pass123"
        });
        response = l.login(request_model: model);

        expect(response.res).to eq :ok;
        expect(response.use_case).to eq "Log In";
    end

    it "returns an [:validation_error, \"Log In\"] on invalid credentials" do
        l = Login.new;
        model1 = RequestModel.new(vals: [
            LoginValidator.new,
            NullLoginValidator.new
        ], data: {
            :username => "alice",
            :pin => "1234",
            :password => "pass123"
        });
        model2 = RequestModel.new(vals: [
            LoginValidator.new,
            NullLoginValidator.new
        ], data: {
            :username => "oblivious",
            :pin => "1234",
            :password => "1234"
        });
        model3 = RequestModel.new(vals: [
            LoginValidator.new,
            NullLoginValidator.new
        ], data: {
            :username => "oblivious",
            :pin => "4242",
            :password => "pass123"
        });

        response1 = l.login(request_model: model1);
        response2 = l.login(request_model: model2);
        response3 = l.login(request_model: model3);

        expect(response1.res).to eq :validation_error;
        expect(response1.use_case).to eq "Log In";
        expect(response2.res).to eq :validation_error;
        expect(response2.use_case).to eq "Log In";
        expect(response3.res).to eq :validation_error;
        expect(response3.use_case).to eq "Log In";
    end
end
