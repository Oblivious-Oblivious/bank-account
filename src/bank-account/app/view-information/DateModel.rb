class DateModel
    private attr_reader :date;

    def get_curr_date
        Time.new;
    end

    def >(other)
        time.to_f > other.to_f;
    end
end
