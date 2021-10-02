class Register < IRegister
    private attr_reader :validator;

    def initialize(validator = DuplicationValidator)
        @validator = validator;
    end

    def register(username:, pin:, password:)
        if validator.validate(username)
            d = DatabaseGateway.new;
            d.store(User.new(username), pin, password);
            [:ok, "Register"];
        else
            [:duplication_error, "Register"];
        end
    end
end
