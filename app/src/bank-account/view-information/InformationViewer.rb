class InformationViewer < IInformationViewer
    def view_account_data(of_user:)
        d = DatabaseGateway.new;

        # TODO Fix use of data here
        user = d.load(of_user);
        user_obj = User.new(d.load(of_user).username);

        [user_obj.hash_id, user.balance, user.transactions];
    end
end
