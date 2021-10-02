class DuplicationValidator
    def self.validate(username)
        d = DatabaseGateway.new;
        d.load(User.new(username)).nil?;
    end
end
