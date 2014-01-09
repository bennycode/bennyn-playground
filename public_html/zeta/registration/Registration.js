Zeta.Registration.Registration = (function() {
  var host, url, user;
  host = 'https://armada-test.z-infra.com';
  url = {
    access: "" + host + "/access",
    login: "" + host + "/login",
    register: "" + host + "/register"
  };
  user = new Zeta.Registration.User();
  return {
    init: function() {
      return $('#registration-form-name').on('blur', function() {
        user.name.value = $(this).val();
        console.log("Username: " + user.name.value + " | valid: " + (user.name.is_valid()));
        if (!user.name.is_valid()) {
          return console.log("username invalid");
        }
      }).focus(function() {
        if (!user.name.is_valid()) {
          return $('#registration-form-name + .guidance').html("<p>" + user.name.guidance.title + "<br/>" + user.name.guidance.explanation + "</p>");
        }
      });
    },
    register: function(user) {
      if (user.has_valid_registration_data) {
        return Zeta.Registration.RequestHandler.postData(url.register, user.get_registration_payload(), function(data, textStatus, jqXHR) {
          console.log("Registration successful");
          return console.log(JSON.stringify(data));
        }, function(data, textStatus, jqXHR) {
          console.log("Registration failed");
          return console.log(JSON.stringify(data));
        });
      }
    }
  };
})();
