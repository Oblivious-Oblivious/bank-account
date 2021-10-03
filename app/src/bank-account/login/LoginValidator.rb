class LoginValidator
    def self.validate(username, pin, password)
        d = DatabaseGateway.new;
        user = d.load(User.new(username));
        not user.nil? and user.pin == pin and user.password == password;
    end
end
