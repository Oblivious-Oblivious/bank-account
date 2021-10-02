class UserValidator
    def self.validate(user)
        not DatabaseGateway.new.load(user).nil?;
    end
end
