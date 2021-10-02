class Withdrawer < IWithdrawer
    private attr_reader :validator;

    def initialize(validator = AmountValidator)
        @validator = validator;
    end

    def withdraw(amount_of:, from_user:)
        if validator.validate(amount_of, from_user)
            d = UserSaverGateway.new;
            d.subtract(from_user, amount_of);
            [:ok, "Withdraw"];
        else
            [:validation_error, "Withdraw"];
        end
    end
end
