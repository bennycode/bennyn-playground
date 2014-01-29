describe("Zeta.Service.Main", function() {

  it("can login a user", function() {
    Zeta.Service.Main.login("me@domain.com", "123456");
    expect(jQuery.fn.jquery).toEqual("2.1.0");
  });

});