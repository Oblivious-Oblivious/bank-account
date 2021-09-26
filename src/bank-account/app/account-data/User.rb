class User
    attr_reader :name, :account_data;

    def initialize(name)
        @name = name;
        @account_data = AccountData.new;
        @account_data.hash_id = BankHashID.new(username: name);
    end

    def add_amount(amount)
        account_data.add_amount(amount);
    end

    def remove_amount(amount)
        account_data.remove_amount(amount);
    end
end
