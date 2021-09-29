require "digest";

class User
    attr_reader :username;

    def initialize(username)
        @username = username;
    end

    def hash_id
        Digest::SHA512.hexdigest(username);
    end
end
