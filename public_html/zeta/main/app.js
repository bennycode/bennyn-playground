(function() {
  var benny;

  benny = new Zeta.Registration.User('Benny', 'benny@wearezeta.com', 'abc123');

  Zeta.Registration.Registration.init();

  Zeta.Registration.Registration.register(benny);

}).call(this);
