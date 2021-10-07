describe InformationViewer do
    before(:each) do
        d = DatabaseGateway.new;
        d.reset_database;
        d.store(User.new("oblivious"), "1337", "l33tc0d3r");
        d.add(User.new("oblivious"), 42);
    end
    after(:each) { DatabaseGateway.new.reset_database; };

    it "responds to :view_account_data" do
        expect(InformationViewer.new).to respond_to(:view_account_data);
    end
    
    it "calls to view information about the users account" do
        iv = InformationViewer.new;
        model = RequestModel.new(vals: [
            NullInformationViewerValidator.new
        ], data: {
            :of_user => User.new("oblivious")
        });
        response = iv.view_account_data(request_model: model);

        expect(response.res).to eq :ok;
        expect(response.use_case).to eq "View Information";
    end

    # TODO Test for valid transaction array
end
