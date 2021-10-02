describe Register do
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

    # it "makes sure the user is saved on successfull register";

    # TODO Register validation test
    #it "returns an [:duplication_error, \"Register\"] on existing credentials";
end
