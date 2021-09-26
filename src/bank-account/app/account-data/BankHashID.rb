require "digest";

class BankHashID
    private attr_reader :username;

    private def hash
        Digest::SHA512.hexdigest(username);
    end

    def initialize(username:)
        @username = username;
    end

    def to_s
        hash;
    end
end
