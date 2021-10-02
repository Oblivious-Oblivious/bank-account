class UserDescriptor
    attr_accessor :username, :balance, :pin, :password;

    def initialize(username, balance, pin, password)
        @username = username;
        @balance = balance;
        @pin = pin;
        @password = password;
    end

    def ==(other)
        username == other.username && balance == other.balance && pin == other.pin && password == other.password;
    end
end
