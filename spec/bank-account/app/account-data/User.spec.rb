describe User do
    it "initializes a new User with a name of 'oblivious'" do
        expect(User.new("oblivious").name).to eq "oblivious";
    end

    it "initalizes mock account data when a new user is created" do
        u = User.new("oblivious");

        expect(u.account_data.to_s).to eq "Hash ID: fda6e88158a9e542f81a1e007d94e2f9c5a9d9f779c7816a1f9bfbd7061cb93143e508c082710917541a2177023c4ae5efd9711beee12724a2e375379347d258\nTotal Amount: $0\nNo. Transactions: 0";
    end
    
    it "adds to total amount" do
        u = User.new("oblivious");
        u.add_amount(42);

        expect(u.account_data.total_amount).to eq 42;
    end

    it "removes from total amount" do
        u = User.new("oblivious");
        u.add_amount(49);
        u.remove_amount(42);

        expect(u.account_data.total_amount).to eq 7;
    end
end
