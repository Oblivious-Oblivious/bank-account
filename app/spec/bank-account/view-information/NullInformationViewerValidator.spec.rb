describe NullInformationViewerValidator do
    before(:each) do
        d = DatabaseGateway.new;
        d.reset_database;
        d.store(User.new("oblivious"), "1337", "l33tc0d3r");
        d.add(User.new("oblivious"), 42);
    end
    after(:each) { DatabaseGateway.new.reset_database; };

    it "fails on any result" do
        expect(NullInformationViewerValidator.new.fails?({})).to eq true;
    end

    it "returns a response model of [:ok, \"View Information\"]" do
        expect(NullInformationViewerValidator.new.response_model.res).to eq :ok;
        expect(NullInformationViewerValidator.new.response_model.use_case).to eq "View Information";
    end

    it "contains an empty :modify_db_state message" do
        expect(NullInformationViewerValidator.new.modify_db_state({})).to eq nil;
    end

    # it "returns a view of the transactions" do
    #     oblivious = User.new("oblivious");
    #     iv = InformationViewer.new;
    #     v = NullInformationViewerValidator.new;

    #     res = v.response_model({:of_user => oblivious});
    #     expect(res.data[0]).to eq "fda6e88158a9e542f81a1e007d94e2f9c5a9d9f779c7816a1f9bfbd7061cb93143e508c082710917541a2177023c4ae5efd9711beee12724a2e375379347d258";
    #     expect(res.data[1]).to eq 42;
    #     expect(res.data[2]).to eq [];
    # end
end
