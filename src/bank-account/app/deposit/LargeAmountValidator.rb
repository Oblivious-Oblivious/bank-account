class LargeAmountValidator
    MAX_AMOUNT = 10000;
    MIN_AMOUNT = 0;

    def self.validate(amount)
        amount < MAX_AMOUNT and amount > MIN_AMOUNT;
    end
end
