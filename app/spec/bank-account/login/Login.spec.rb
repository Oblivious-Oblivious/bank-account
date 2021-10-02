describe Login do
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

    # TODO
    #it "returns an [:validation_error, \"Log In\"] on invalid credentials";
end
