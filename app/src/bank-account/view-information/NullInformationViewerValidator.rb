class NullInformationViewerValidator
    # TODO Implement passing of data through via the response model
    # private def res_data(data)
    #     d = DatabaseGateway.new;

    #     user = d.load(data[:of_user]);
    #     user_obj = User.new(d.load(data[:of_user]).username);

    #     [user_obj.hash_id, user.balance, user.transactions];
    # end

    def modify_db_state(_)
    end

    def fails?(_)
        true;
    end

    def response_model#(data)
        ResponseModel.new(
            res: :ok,
            use_case: "View Information",
            data: {}#res_data(data)
        );
    end
end
