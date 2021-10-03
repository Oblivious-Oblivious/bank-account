class AmountValidator
    def self.validate(amount, user)
        d = DatabaseGateway.new;
        d.load(user).balance >= amount and amount > 0;
    end
end
