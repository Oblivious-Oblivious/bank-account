class Sender < ISender
    private attr_reader :amount_validator, :user_validator;

    private def user_validation_fails(sender, receiver)
        not (user_validator.validate(receiver) && user_validator.validate(sender));
    end

    private def amount_validation_fails(amount, sender)
        not amount_validator.validate(amount, sender);
    end

    def initialize(amount_validator = AmountValidator, user_validator = UserValidator)
        @amount_validator = amount_validator;
        @user_validator = user_validator;
    end

    def send(amount_of:, from_user:, to_user:)
        if amount_validation_fails(amount_of, from_user)
            [:amount_error, "Send"];
        elsif user_validation_fails(from_user, to_user)
            [:hash_id_error, "Send"];
        else
            d = DatabaseGateway.new;
            d.add(to_user, amount_of);
            d.subtract(from_user, amount_of);
            [:ok, "Send"];
        end
    end
end
