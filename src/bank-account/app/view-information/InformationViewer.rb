class InformationViewer < IInformationViewer
    attr_accessor :account_data;

    def initialize
        @account_data = AccountData.new;
    end

    def view_account_data
        account_data;
    end
end
