require "rspec/autorun";

# All source files
Dir[Dir.pwd + "/src/bank-account/**/*.rb"].each { |f| require f };

# All spec files
Dir[Dir.pwd + "/spec/bank-account/**/*.spec.rb"].each { |f| require f };
