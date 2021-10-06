class UserValidator
    def modify_db_state(_)
    end

    def fails?(data)
        d = DatabaseGateway.new;
        d.load(data[:from_user]).nil? or d.load(data[:to_user]).nil?;
    end

    def response_model
        ResponseModel.new(res: :hash_id_error, use_case: "Send", data: {});
    end
end
