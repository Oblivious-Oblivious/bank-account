class Transaction
    include Comparable;
    attr_accessor :sender, :receiver, :amount, :date;

    def initialize(sender:, receiver:, amount:)
        @sender = sender;
        @receiver = receiver;
        @amount = amount;
        @date = Time.now;
    end

    def <=>(other)
        @sender <=> other.sender and @receiver <=> other.receiver and @amount <=> other.amount;
    end
end
