class LargeAmountValidator
    MAX_AMOUNT = 10000;
    MIN_AMOUNT = 0;

    def modify_db_state(_)
    end

    def fails?(data)
        not (data[:amount_of] < MAX_AMOUNT and data[:amount_of] > MIN_AMOUNT);
    end

    def response_model
        ResponseModel.new(res: :large_amount_error, use_case: "Deposit", data: {});
    end
end
