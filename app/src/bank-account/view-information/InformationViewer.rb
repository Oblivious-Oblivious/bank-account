class InformationViewer < IInformationViewer
    def view_account_data(of_user:)
        d = DatabaseGateway.new;

        # TODO Fix use of data here
        hash_id = User.new(d.load(of_user).username).hash_id;
        balance = d.load(of_user).balance;
        # TODO Transactions
        transaction_info = [];

        [hash_id, balance, transaction_info];
    end
end
