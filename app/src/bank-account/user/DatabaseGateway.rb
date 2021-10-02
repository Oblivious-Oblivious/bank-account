require "./database/src/user_saver";

# TODO Try detatching, DB connects everything too much.
class DatabaseGateway
    private attr_reader :db;

    def initialize(db = UserSaver.new)
        @db = db;
    end

    def store(user, pin, password)
        db.new_user(user.username, pin, password);
    end

    def load_all_users
        db.load_stored_users;
    end

    def add(user, amount)
        db.add_user_balance(user.username, amount);
    end

    def subtract(user, amount)
        db.subtract_user_balance(user.username, amount);
    end

    def update(user, username, pin, password)
        db.update_user_information(user.username, {
            "username" => username,
            "pin" => pin,
            "password" => password
        });
    end

    def load(user)
        load_all_users["users"][user.username];
    end

    def reset_database
        load_all_users["users"].each do |user|
            db.delete_user(user[0]);
        end
    end
end
