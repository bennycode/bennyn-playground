property = new Zeta.Registration.UserProperty("property")
#alert property.value
#alert property.isValid()

pw = new Zeta.Registration.UserPassword("password")
#alert pw.value
#alert pw.isValid()

email = new Zeta.Registration.UserEmailAddress("email")
#alert email.value
#alert email.isValid()

user = new Zeta.Registration.User("Benny", "benny@wearezeta.com", "abc123")
alert user.name.value

Zeta.Registration.Registration.test()