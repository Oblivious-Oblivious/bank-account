class InformationViewer < IInformationViewer
    def view_account_data(of_user:)
        d = UserSaverGateway.new;
        hash_id = d.load(of_user).user.hash_id;
        balance = d.load(of_user).balance
        # TODO Transactions
        transaction_info = [];

        [hash_id, balance, transaction_info];
    end
end
