describe User do
    it "has a username" do
        u = User.new("oblivious");
        expect(u.username).to eq("oblivious");
    end

    it "generates a SHA512 id for the username" do
        u = User.new("oblivious");
        expect(u.hash_id()).to eq("fda6e88158a9e542f81a1e007d94e2f9c5a9d9f779c7816a1f9bfbd7061cb93143e508c082710917541a2177023c4ae5efd9711beee12724a2e375379347d258");
    end
end
