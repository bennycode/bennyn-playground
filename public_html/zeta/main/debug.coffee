property = new Zeta.Registration.UserProperty("property")
#console.log property.value
#console.log property.is_valid()
#console.log property.guidance.title

pw = new Zeta.Registration.UserPassword("password!!!")
console.log pw.value
console.log pw.guidance.title
#console.log pw.is_valid()

email = new Zeta.Registration.UserEmailAddress("email")
#console.log email.value
#console.log email.is_valid()

user = new Zeta.Registration.User("Benny", "benny@wearezeta.com", "abc123")
#console.log user.name.value

#Zeta.Registration.UserBuilder.test()