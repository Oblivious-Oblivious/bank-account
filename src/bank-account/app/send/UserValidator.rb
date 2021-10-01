class UserValidator
    def self.validate(user)
        not UserSaverGateway.new.load(user).nil?;
    end
end
