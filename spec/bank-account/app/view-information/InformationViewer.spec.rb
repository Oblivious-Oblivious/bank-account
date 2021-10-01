describe InformationViewer do
    before(:each) do
        d = UserSaverGateway.new;
        d.reset_database;
        d.store(User.new("oblivious"), "1337", "l33tc0d3r");
        d.add(User.new("oblivious"), 42);
    end

    it "responds to :view_account_data" do
        expect(InformationViewer.new).to respond_to(:view_account_data);
    end

    it "returns an array representing user information when view_account_data is called" do
        oblivious = User.new("oblivious");
        iv = InformationViewer.new;
        expect(iv.view_account_data(of_user: oblivious)).to eq ["fda6e88158a9e542f81a1e007d94e2f9c5a9d9f779c7816a1f9bfbd7061cb93143e508c082710917541a2177023c4ae5efd9711beee12724a2e375379347d258", 42, []];
    end
end
