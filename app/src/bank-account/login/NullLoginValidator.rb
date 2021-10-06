class NullLoginValidator
    def modify_db_state(_)
    end

    def fails?(_)
        true;
    end

    def response_model
        ResponseModel.new(res: :ok, use_case: "Log In", data: {});
    end
end
