class UserDescriptor
    attr_accessor :username, :balance, :pin, :password, :transactions;

    def transactions_equal(other)
        # TODO Try refactor
        transactions.each_with_index do |_, i|
            return false if transactions[i] != other.transactions[i];
        end
        true;
    end

    def initialize(username, pin, password)
        @username = username;
        @pin = pin;
        @password = password;

        @balance = 0;
        @transactions = [];
    end

    def ==(other)
        username == other.username && balance == other.balance && pin == other.pin && password == other.password && transactions_equal(other);
    end
end
