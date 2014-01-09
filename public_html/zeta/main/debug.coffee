property = new Zeta.Registration.UserProperty("property")
alert property.value
alert property.is_valid()

pw = new Zeta.Registration.UserPassword("password")
alert pw.value
alert pw.is_valid()

email = new Zeta.Registration.UserEmailAddress("email")
alert email.value
alert email.is_valid()

user = new Zeta.Registration.User("Benny", "benny@wearezeta.com", "abc123")
alert user.name.value

#Zeta.Registration.Registration.test()