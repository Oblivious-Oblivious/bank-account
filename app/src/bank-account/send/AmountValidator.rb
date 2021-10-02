require_relative "../user/UserSaverGateway";

class AmountValidator
    def self.validate(amount, user)
        d = UserSaverGateway.new;
        d.load(user).balance >= amount && amount > 0;
    end
end
