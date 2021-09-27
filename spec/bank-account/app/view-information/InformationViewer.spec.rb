describe InformationViewer do
    it "responds to #view_account_data" do
        expect(InformationViewer.new).to respond_to :view_account_data;
    end

    it "returns an AccountData object when `view_account_data` is called" do
        expect(InformationViewer.new.view_account_data).to be_an_instance_of AccountData;
    end

    it "returns a visual representation of AccountData" do
        vi = InformationViewer.new;
        mock_data = AccountData.new;
        mock_data.hash_id = BankHashID.new(username: "oblivious");
        mock_data.total_amount = 42;
        mock_data.transaction_information = [
            Transaction.new.create(sender: "oblivious", receiver: "bank"),
            Transaction.new.create(sender: "bank", receiver: "oblivious"),
            Transaction.new.create(sender: "oblivious", receiver: "alice"),
        ];

        vi.account_data = mock_data;

        expect(vi.view_account_data.to_s).to eq "Hash ID: fda6e88158a9e542f81a1e007d94e2f9c5a9d9f779c7816a1f9bfbd7061cb93143e508c082710917541a2177023c4ae5efd9711beee12724a2e375379347d258\nTotal Amount: $42\nNo. Transactions: 3";
    end
end
