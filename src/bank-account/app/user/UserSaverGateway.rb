class UserSaverGateway
    private attr_reader :db;

    def initialize
        @db = UserSaver.new;
    end

    def store(user, pin, password)
        db.new_user(user, pin, password);
    end

    def load_all_users
        db.load_stored_users;
    end

    def add(user, amount)
        db.add_user_balance(user, amount);
    end

    def subtract(user, amount)
        db.subtract_user_balance(user, amount);
    end

    def update(user, username, pin, password)
        db.update_user_information(user, {
            "username" => username,
            "pin" => pin,
            "password" => password
        });
    end

    def reset_database
        load_all_users["users"].each do |user_object|
            db.delete_user(user_object[1].user);
        end
    end
end
