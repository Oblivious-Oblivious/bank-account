require "./database/src/user_saver";

class IDatabaseGateway
    def store(user, pin, password) = raise(self);
    def add(user, amount) = raise(self);
    def subtract(user, amount) = raise(self);
    def update(user, username, pin, password) = raise(self);
    def log_transaction(user, transaction) = raise(self);
end
