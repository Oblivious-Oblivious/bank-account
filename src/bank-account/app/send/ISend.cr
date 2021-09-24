abstract class ISend
    abstract def send_amount(
        recipient_hash : BankHashID,
        transfer_amount : Integer,
        fee_amount : Integer
    ) : TransactionID;
end
