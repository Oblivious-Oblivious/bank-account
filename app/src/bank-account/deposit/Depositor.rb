require_relative "IDepositor";

class Depositor < IDepositor
    private attr_reader :validator;

    def initialize(validator = LargeAmountValidator)
        @validator = validator;
    end

    def deposit(amount_of:, to_user:)
        if validator.validate(amount_of)
            d = UserSaverGateway.new;
            d.add(to_user, amount_of);
            [:ok, "Deposit"];
        else
            [:large_amount_error, "Deposit"];
        end
    end
end
