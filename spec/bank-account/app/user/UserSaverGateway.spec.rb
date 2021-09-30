require "./src/bank-account/database/user_saver";

describe UserSaverGateway do
    before :each do
        d = UserSaverGateway.new;
        d.reset_database;
    end

    it "registers a new user into the database" do
        d = UserSaverGateway.new;
        oblivious = User.new("oblivious");

        d.store(oblivious, "1234", "pass123");
        expect(d.load_all_users["users"].count).to eq 1;
    end

    it "registers two extra users into the database" do
        d = UserSaverGateway.new;

        d.store(User.new("u1"), "0000", "0000");
        d.store(User.new("u2"), "0000", "0000");

        expect(d.load_all_users["users"].count).to eq 2;
    end

    it "adds to the balance of a user" do
        d = UserSaverGateway.new;
        oblivious = User.new("oblivious");

        d.store(oblivious, "1234", "pass123");
        d.add(User.new("oblivious"), 42);

        expect(d.load_all_users["users"]["oblivious"].balance).to eq 42;
    end

    it "subtracts from the balance of a user" do
        d = UserSaverGateway.new;
        oblivious = User.new("oblivious");

        d.store(oblivious, "1234", "pass123");
        d.add(oblivious, 49);
        d.subtract(oblivious, 42);

        expect(d.load_all_users["users"]["oblivious"].balance).to eq 7;
    end

    it "updates the information of a user" do
        d = UserSaverGateway.new;
        oblivious = User.new("oblivious");

        d.store(oblivious, "1234", "pass123");
        d.add(oblivious, 42);
        d.update(oblivious, "oblivious", "4242", "random42");

        updated_user = d.load_all_users["users"]["oblivious"];
        expect(updated_user.user).to eq User.new("oblivious");
        expect(updated_user.balance).to eq 42;
        expect(updated_user.pin).to eq "4242";
        expect(updated_user.password).to eq "random42";
    end
end
