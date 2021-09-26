require "digest";

class Transaction
    attr_reader :tid, :sender, :receiver, :date;

    private def hash(transaction_id)
        Digest::SHA512.hexdigest(transaction_id);
    end

    def initialize
        @tid = "id";
        @sender = "";
        @receiver = "";
        @date = nil;
    end

    def create(sender:, receiver:)
        @sender = sender;
        @receiver = receiver;
        @tid = hash("#{sender} to #{receiver}");
        @date = Time.new;
    end
end
