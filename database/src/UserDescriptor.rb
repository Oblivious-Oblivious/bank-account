class UserDescriptor
    attr_accessor :user, :balance, :pin, :password;

    def initialize(user, balance, pin, password)
        @user = user;
        @balance = balance;
        @pin = pin;
        @password = password;
    end

    def ==(other)
        user == other.user && balance == other.balance && pin == other.pin && password == other.password;
    end
end
