var email, property, pw, user;

property = new Zeta.Registration.UserProperty("property");

pw = new Zeta.Registration.UserPassword("password!!!");

console.log(pw.value);

console.log(pw.guidance.title);

email = new Zeta.Registration.UserEmailAddress("email");

user = new Zeta.Registration.User("Benny", "benny@wearezeta.com", "abc123");
