class LoginValidator
    def self.validate(username, pin, password)
        d = DatabaseGateway.new;
        user = d.load(User.new(username));
        !user.nil? && user.pin == pin && user.password == password;
    end
end
