require "digest";

class User
    include Comparable;
    attr_reader :username;

    def initialize(username)
        @username = username;
    end

    def hash_id
        Digest::SHA512.hexdigest(username);
    end

    def <=>(other)
        username <=> other;
    end
end
