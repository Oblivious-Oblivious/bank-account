require "rspec/autorun";

require "yaml";
require_relative "../src/user_saver";

describe UserSaver do
    DB_PATH = "database/_users.db";

    before(:each) do
        File.delete(DB_PATH) if File.exist?(DB_PATH);
    end

    it "responds to :new_user, :update_user_information, :add_user_balance, :subtract_user_balance, :delete_user" do
        saver = UserSaver.new;
        expect(saver).to respond_to(:new_user);
        expect(saver).to respond_to(:update_user_information);
        expect(saver).to respond_to(:add_user_balance);
        expect(saver).to respond_to(:subtract_user_balance);
        expect(saver).to respond_to(:delete_user);
    end

    context "#new_user" do
        it "stores a new user with $0 of balance in the db file" do
            saver = UserSaver.new;
            saver.new_user("oblivious");

            users = YAML::load(File.read(DB_PATH));

            udesc_expected = UserDescriptor.new("oblivious", "0000", "0000");
            expect(users["users"]["oblivious"]).to eq(udesc_expected);
        end

        it "does not create a new user with a username that already exists" do
            saver = UserSaver.new;
            saver.new_user("oblivious");
            saver.new_user("oblivious");

            # TODO Fix test, loader autoremoves duplicates
            # but we should be not adding in the first place
            users = YAML::load(File.read(DB_PATH));
        end

        it "creates two users and displays them" do
            saver = UserSaver.new;
            saver.new_user("alice");
            saver.new_user("bob");

            users = YAML::load(File.read(DB_PATH));

            alice = UserDescriptor.new("alice", "0000", "0000");
            bob = UserDescriptor.new("bob", "0000", "0000");
            expect(users["users"]["bob"]).to eq(bob);
            expect(users["users"]["alice"]).to eq(alice);
        end
    end

    context "#update_user_information" do
        it "updates information of a single user" do
            saver = UserSaver.new;
            user_to_update = "oblivious";
            saver.new_user(user_to_update, "4242", "random42");
            saver.update_user_information(user_to_update, {
                "pin" => "1234",
                "password" => "pass123"
            });

            users = YAML::load(File.read(DB_PATH));

            expect(users["users"]["oblivious"].pin).to eq("1234");
            expect(users["users"]["oblivious"].password).to eq("pass123");
        end

        it "updates the information of a user twice and keeps the second version" do
            saver = UserSaver.new;
            user_to_update = "oblivious";
            saver.new_user(user_to_update, "4242", "random42");
            saver.update_user_information(user_to_update, {
                "pin" => "1234",
                "password" => "pass123"
            });
            # Twice
            saver.update_user_information(user_to_update, {
                "pin" => "4567",
                "password" => "qwerty987"
            });

            users = YAML::load(File.read(DB_PATH));

            expect(users["users"]["oblivious"].pin).to eq("4567");
            expect(users["users"]["oblivious"].password).to eq("qwerty987");
        end

        it "updates information of two different users" do
            saver = UserSaver.new;
            alice = "Alice";
            bob = "Bob";

            saver.new_user(alice, "1234", "pass123");
            saver.new_user(bob, "9876", "qwerty987");

            saver.update_user_information(alice, {
                "pin" => "0000",
                "password" => "0000"
            });
            saver.update_user_information(bob, {
                "pin" => "0000",
                "password" => "0000"
            });

            users = YAML::load(File.read(DB_PATH));

            expect(users["users"]["Alice"].pin).to eq("0000");
            expect(users["users"]["Alice"].password).to eq("0000");
            expect(users["users"]["Bob"].pin).to eq("0000");
            expect(users["users"]["Bob"].password).to eq("0000");
        end
    end

    context "#add_user_balance" do
        it "adds $42 to a users balance" do
            saver = UserSaver.new;
            oblivious = "oblivious";

            saver.new_user(oblivious, "4242", "random42");
            saver.add_user_balance(oblivious, 42);

            users = YAML::load(File.read(DB_PATH));

            expect(users["users"]["oblivious"].balance).to eq(42);
        end
    end

    context "#subtract_user_balance" do
        it "subtracts a valid amount of $42 from a users balance" do
            saver = UserSaver.new;
            oblivious = "oblivious";

            saver.new_user(oblivious, "4242", "random42");
            saver.add_user_balance(oblivious, 49);
            saver.subtract_user_balance(oblivious, 42);
            
            users = YAML::load(File.read(DB_PATH));

            expect(users["users"]["oblivious"].balance).to eq(7);
        end

        it "rejects an invalid subtraction of $42 when user has a lesser amount" do
            saver = UserSaver.new;
            oblivious = "oblivious";

            saver.new_user(oblivious, "4242", "random42");
            saver.add_user_balance(oblivious, 7);
            saver.subtract_user_balance(oblivious, 42);

            users = YAML::load(File.read(DB_PATH));

            expect(users["users"]["oblivious"].balance).to eq(7);
        end
    end

    context "#log_transaction" do
        it "logs the transaction information in the UserDescriptor's field" do
            saver = UserSaver.new;
            user = "alice";

            saver.new_user(user, "4242", "random42");
            saver.log_transaction(user, {
                "sender" => "alice",
                "receiver" => "bob",
                "amount" => 42,
                "date" => Time.now
            });

            users = YAML::load(File.read(DB_PATH));
            expect(users["users"]["alice"].transactions.size).to eq 1;
            expect(users["users"]["alice"].transactions[0]["sender"]).to eq("alice");
            expect(users["users"]["alice"].transactions[0]["receiver"]).to eq("bob");
            expect(users["users"]["alice"].transactions[0]["amount"]).to eq(42);
        end
    end

    context "#delete_user" do
        it "does nothing if asked to delete an non existent user" do
            saver = UserSaver.new;
            saver.delete_user("non_existent");

            users = YAML::load(File.read(DB_PATH));
            expect(users["users"]).to be {};
        end

        it "deletes an existent user" do
            saver = UserSaver.new;
            oblivious = "oblivious";
            
            saver.new_user(oblivious, "4242", "random42");
            saver.new_user("random", "0000", "0000");
            saver.delete_user(oblivious);

            users = YAML::load(File.read(DB_PATH));

            expect(users["users"]["oblivious"]).to be nil;
        end

        it "tries to delete an existing user twice but only does so once" do
            saver = UserSaver.new;
            oblivious = "oblivious";
            saver.new_user(oblivious, "4242", "random42");
            saver.delete_user(oblivious);
            saver.delete_user(oblivious);

            users = YAML::load(File.read(DB_PATH));

            expect(users["users"]["oblivious"]).to be nil;
        end
    end
end
