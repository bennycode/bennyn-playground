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
      $('#registration-form-name').on("focus keyup paste", function() {
        user.name.value = $(this).val();
        user.name.validate();
        return $('#registration-form-name + .guidance').html("<p>" + user.name.guidance.title + "<br/>" + user.name.guidance.explanation + "</p>");
      });
      return $('#registration-form-email').on("focus keyup paste", function() {
        user.email.value = $(this).val();
        user.email.validate();
        return $('#registration-form-email + .guidance').html("<p>" + user.email.guidance.title + "<br/>" + user.email.guidance.explanation + "</p>");
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
