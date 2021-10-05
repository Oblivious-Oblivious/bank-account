require_relative "IDepositor";

class Depositor < IDepositor
    def deposit(request_model:)
        request_model.vals.each do |v|
            if v.fails?(request_model.data)
                v.modify_db_state(request_model.data);
                return v.response_model;
            end
        end
    end
end
