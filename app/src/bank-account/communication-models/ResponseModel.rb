class ResponseModel
    include Comparable;
    attr_reader :res, :use_case, :data;

    def initialize(res:, use_case:, data:)
        @res = res;
        @use_case = use_case;
        @data = data;
    end

    def to_s
        "[:#{res}, \"#{use_case}\", #{data.keys}]";
    end

    def <=>(other)
        res <=> other.res and use_case <=> other.use_case and data <=> other.data;
    end
end
