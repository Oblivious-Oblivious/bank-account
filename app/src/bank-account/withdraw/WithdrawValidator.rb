class WithdrawValidator
    def modify_db_state(_)
    end

    def fails?(data)
        d = DatabaseGateway.new;
        not (d.load(data[:from_user]).balance >= data[:amount_of] and data[:amount_of] > 0);
    end

    def response_model
        ResponseModel.new(res: :amount_error, use_case: "Withdraw", data: {});
    end
end
