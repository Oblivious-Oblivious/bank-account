abstract class ILogin
    abstract def login(
        pin : Integer,
        password : String,
        biometric : BiometricData
    ) : Session;
end
