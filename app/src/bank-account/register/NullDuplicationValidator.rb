class NullDuplicationValidator
    def modify_db_state(data)
        DatabaseGateway.new.store(
            User.new(data[:username]),
            data[:pin],
            data[:password]
        );
    end

    def fails?(_)
        true;
    end

    def response_model
        ResponseModel.new(res: :ok, use_case: "Register", data: {});
    end
end
