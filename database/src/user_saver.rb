require_relative "UserDescriptor";
require "yaml";

class UserSaver
    DB_PATH = "database/_users.db";

    private def user_exists_in_db(users, user)
        return false if (!users["users"] || users["users"].size == 0);
        users["users"][user];
    end

    private def user_does_not_exist_in_db(users, user)
        !user_exists_in_db(users, user);
    end

    private def update_users(users, user, pin, password)
        udesc = UserDescriptor.new(user, pin, password);
        if !users["users"]
            users["users"] = {user => udesc};
        else
            users["users"][user] = udesc;
        end
    end

    private def write_to_db(data)
        file = File.new(DB_PATH, "w");
        file.puts data;
        file.close;
    end

    def initialize
        if !File.exist?(DB_PATH)
            File.open(DB_PATH, "w") do |f|
                f.puts "users: {}";
            end
        end
    end

    def load_stored_users
        YAML::load(File.read(DB_PATH));
    end

    def new_user(user, pin = "0000", password = "0000")
        users = load_stored_users();
        return if user_exists_in_db(users, user);

        update_users(users, user, pin, password);
        write_to_db(users.to_yaml);
    end

    def update_user_information(user, user_data)
        users = load_stored_users();
        return if user_does_not_exist_in_db(users, user);

        user_to_update = users["users"][user];
        user_to_update.pin = user_data["pin"];
        user_to_update.password = user_data["password"];

        write_to_db(users.to_yaml);
    end

    def add_user_balance(user, amount)
        users = load_stored_users();
        return if user_does_not_exist_in_db(users, user);

        users["users"][user].balance += amount;

        write_to_db(users.to_yaml);
    end

    def subtract_user_balance(user, amount)
        users = load_stored_users();
        return if user_does_not_exist_in_db(users, user);

        # TODO Refactor validation
        curr_balance = users["users"][user].balance;
        if curr_balance - amount < 0
            return;
        else
            users["users"][user].balance -= amount;
        end

        write_to_db(users.to_yaml);
    end

    def delete_user(user)
        users = load_stored_users();
        return if user_does_not_exist_in_db(users, user);

        users["users"].delete(user);

        write_to_db(users.to_yaml);
    end
end
