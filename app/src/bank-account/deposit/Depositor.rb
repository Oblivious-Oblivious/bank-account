require_relative "IDepositor";

class Depositor < IDepositor
    private attr_reader :validator;

    def initialize(validator = LargeAmountValidator)
        @validator = validator;
    end

    def deposit(amount_of:, to_user:)
        if validator.validate(amount_of)
            d = DatabaseGateway.new;
            d.add(to_user, amount_of);
            d.log_transaction(to_user, Transaction.new(
                sender: to_user,
                receiver: User.new("Bank Account"),
                amount: amount_of
            ));
            [:ok, "Deposit"];
        else
            [:large_amount_error, "Deposit"];
        end
    end
end
