class Withdrawer < IWithdrawer
    private attr_reader :validator;

    def initialize(validator = AmountValidator)
        @validator = validator;
    end

    def withdraw(amount_of:, from_user:)
        if validator.validate(amount_of, from_user)
            d = DatabaseGateway.new;
            d.subtract(from_user, amount_of);
            d.log_transaction(from_user, Transaction.new(
                sender: User.new("Bank Account"),
                receiver: from_user,
                amount: amount_of
            ));
            [:ok, "Withdraw"];
        else
            [:validation_error, "Withdraw"];
        end
    end
end
