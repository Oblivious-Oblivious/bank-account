class NullWithdrawValidator
    def modify_db_state(data)
        d = DatabaseGateway.new;
        d.subtract(data[:from_user], data[:amount_of]);
        d.log_transaction(data[:from_user], Transaction.new(
            sender: User.new("Bank Account"),
            receiver: data[:from_user],
            amount: data[:amount_of]
        ));
    end

    def fails?(_)
        true;
    end

    def response_model
        ResponseModel.new(res: :ok, use_case: "Withdraw", data: {});
    end
end
