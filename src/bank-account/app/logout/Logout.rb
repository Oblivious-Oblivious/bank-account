class Logout < ILogout
    def logout(user:)
        [:ok, "Log Out"];
    end
end
