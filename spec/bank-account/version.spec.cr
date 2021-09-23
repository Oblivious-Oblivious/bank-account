CURR_VERSION = "0.1.0";

describe BankAccount do
    it "checks that latest version should be #{CURR_VERSION}" do
        BankAccount::VERSION.should eq CURR_VERSION;
    end
end
