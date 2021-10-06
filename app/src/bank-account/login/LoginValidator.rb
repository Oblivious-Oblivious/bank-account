class LoginValidator
    def modify_db_state(_)
    end

    def fails?(data)
        d = DatabaseGateway.new;
        user = d.load(User.new(data[:username]));
        not (not user.nil? and user.pin == data[:pin] and user.password == data[:password]);
    end

    def response_model
        ResponseModel.new(res: :validation_error, use_case: "Log In", data: {});
    end
end
