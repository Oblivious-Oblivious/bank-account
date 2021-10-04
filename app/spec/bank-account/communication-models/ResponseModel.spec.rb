describe ResponseModel do
    it "contains a response literal used as a message" do
        rm = ResponseModel.new(res: :ok, use_case: "Deposit", data: {});
        expect(rm.res).to eq(:ok);
    end

    it "contains a data hash to be used by possible presenter object" do
        rm = ResponseModel.new(res: :ok, use_case: "Deposit", data: {
            "elem1" => 42,
            "elem2" => "random",
            "elem3" => User.new("oblivious")
        });

        expect(rm.data.size).to eq 3;
        expect(rm.data["elem1"]).to eq 42;
        expect(rm.data["elem2"]).to eq "random";
        expect(rm.data["elem3"].username).to eq "oblivious";
    end

    it "presents itself in string mode" do
        rm = ResponseModel.new(res: :ok, use_case: "Deposit", data: {
            "elem1" => 42,
            "elem2" => "random",
            "elem3" => User.new("oblivious")
        });

        expect(rm.to_s).to eq "[:ok, \"Deposit\", [\"elem1\", \"elem2\", \"elem3\"]]";
    end

    it "compares two response models by `res`, `user_case` and `data`" do
        rm1 = ResponseModel.new(res: :ok, use_case: "Deposit", data: {});
        rm2 = ResponseModel.new(res: :ok, use_case: "Deposit", data: {});

        expect(rm1).to eq rm2;
    end
end
