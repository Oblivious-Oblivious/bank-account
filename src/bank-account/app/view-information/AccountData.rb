class AccountData
    attr_accessor :hash_id;
    attr_accessor :total_amount;
    attr_accessor :transaction_information;

    def initialize
        @transaction_information = Array.new;
    end
end
