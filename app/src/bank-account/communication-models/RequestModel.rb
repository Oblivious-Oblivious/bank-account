class RequestModel
    include Comparable;
    attr_reader :vals, :data;

    def initialize(vals:, data:)
        @vals = vals;
        @data = data;
    end

    def to_s
        "[#{vals},#{data.keys}]";
    end

    def <=>(other)
        vals <=> other.vals and data <=> other.data;
    end
end
