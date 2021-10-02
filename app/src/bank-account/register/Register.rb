class Register < IRegister
    private attr_reader :validator;

    def initialize(validator = DuplicationValidator)
        @validator = validator;
    end

    def register(username:, pin:, password:)
        if validator.validate(username)
            [:ok, "Register"];
        else
            [:validation_error, "Register"];
        end
    end
end
