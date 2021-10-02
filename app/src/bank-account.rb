Dir[Dir.pwd + "/app/src/bank-account/**/*.rb"].each { |f| require f };

# Defines the main functionality when running the system
module BankAccount::Main
    def self.run
        42;
    end
end

p BankAccount::Main.run;
p BankAccount::VERSION;
