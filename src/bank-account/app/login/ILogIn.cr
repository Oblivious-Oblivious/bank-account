abstract class ILogin
    abstract def login(
        pin : Integer,
        password : String,
        biometric : BiometricData
    ) : LoginModel;
end
