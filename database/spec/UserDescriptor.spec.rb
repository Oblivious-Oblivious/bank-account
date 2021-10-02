require "rspec/autorun";
require_relative "../src/UserDescriptor";

describe UserDescriptor do
    it "creates a new UserDescriptor with a User named 'oblivious' and a balance of $42" do
        udesc = UserDescriptor.new("oblivious", "", "");

        expect(udesc.username).to eq("oblivious");
        expect(udesc.balance).to eq(0);
    end

    it "compares two users for equality" do
        udesc1 = UserDescriptor.new("oblivious", "4242", "pass");
        udesc2 = UserDescriptor.new("oblivious", "4242", "pass");

        expect(udesc1).to eq(udesc2);
    end

    it "saves a password and PIN field" do
        udesc = UserDescriptor.new("oblivious", "0000", "pass");

        expect(udesc.username).to eq("oblivious");
        expect(udesc.balance).to eq(0);
        expect(udesc.pin).to eq("0000");
        expect(udesc.password).to eq("pass");
    end

    it "saves a transactions array" do
        udesc = UserDescriptor.new("oblivious", "0000", "pass");
        expect(udesc.transactions.size).to eq 0;
    end
end
