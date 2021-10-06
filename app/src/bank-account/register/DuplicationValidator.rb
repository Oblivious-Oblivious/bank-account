class DuplicationValidator
    def modify_db_state(_)
    end

    def fails?(data)
        d = DatabaseGateway.new;
        not d.load(User.new(data[:username])).nil?;
    end

    def response_model
        ResponseModel.new(res: :duplication_error, use_case: "Register", data: {});
    end
end
