class Login < ILogin
    private attr_reader :validator;

    def initialize(validator = LoginValidator)
        @validator = validator;
    end

    def login(username:, pin:, password:)
        if validator.validate(username, pin, password)
            [:ok, "Log In"];
        else
            [:validation_error, "Log In"];
        end
    end
end
