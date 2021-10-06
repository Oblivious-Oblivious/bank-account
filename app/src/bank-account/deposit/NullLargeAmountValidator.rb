class NullLargeAmountValidator
    def modify_db_state(data)
        d = DatabaseGateway.new;
        d.add(data[:to_user], data[:amount_of]);
        d.log_transaction(data[:to_user], Transaction.new(
            sender: data[:to_user],
            receiver: User.new("Bank Account"),
            amount: data[:amount_of]
        ));
    end

    def fails?(_)
        true;
    end

    def response_model
        ResponseModel.new(res: :ok, use_case: "Deposit", data: {});
    end
end
