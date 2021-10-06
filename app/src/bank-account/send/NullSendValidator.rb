class NullSendValidator
    def modify_db_state(data)
        d = DatabaseGateway.new;
        d.add(data[:to_user], data[:amount_of]);
        d.subtract(data[:from_user], data[:amount_of]);

        tr = Transaction.new(
            sender: data[:from_user],
            receiver: data[:to_user],
            amount: data[:amount_of]
        );
        d.log_transaction(data[:from_user], tr);
        d.log_transaction(data[:to_user], tr);
    end

    def fails?(_)
        true;
    end

    def response_model
        ResponseModel.new(res: :ok, use_case: "Send", data: {});
    end
end
