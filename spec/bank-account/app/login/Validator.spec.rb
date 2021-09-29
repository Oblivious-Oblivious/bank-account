describe Validator do
    it "validates valid username, pin and password" do
        v = Validator.new;
        response = v.validate_input("oblivious", 1234, "pass123");

        expect(response).to eq true;
    end
end
