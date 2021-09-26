class AccountData
    attr_accessor :hash_id;
    attr_accessor :total_amount;
    attr_accessor :transaction_information;

    def initialize
        @total_amount = 0;
        @transaction_information = Array.new;
    end

    def add_amount(amount)
        @total_amount += amount;
    end

    def remove_amount(amount)
        @total_amount -= amount;
    end

    def to_s
        "Hash ID: #{hash_id}\nTotal Amount: $#{total_amount}\nNo. Transactions: #{transaction_information.size}";
    end
end
