class Login < ILogin
    private attr_reader :validator;

    def initialize(validator = Validator.new)
        @validator = validator;
    end

    def login(username:, pin:, password:)
        if validator.validate_input(username, pin, password)
            [:ok, "Log In"];
        else
            [:validation_error, "Log In"];
        end
    end
end
