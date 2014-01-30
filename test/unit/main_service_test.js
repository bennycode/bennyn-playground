describe("Zeta.Service.Main", function() {

  it("can login a user", function() {
    var email = "unit-test@wearezeta.com";
    var password = "123456";

    Zeta.Service.Main.login(email, password);
    expect(Zeta.Storage.Session.get_own_user().email).toEqual(email);
  });

});