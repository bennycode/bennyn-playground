Zeta.Registration.Registration = (function() {
  var hide_other_guides, host, initProperty, url, user;
  host = 'https://armada-test.z-infra.com';
  url = {
    access: "" + host + "/access",
    login: "" + host + "/login",
    register: "" + host + "/register"
  };
  user = new Zeta.Registration.User();
  hide_other_guides = function() {
    return $('.guidance').css('display', 'none');
  };
  initProperty = function(selector, property) {
    console.log(selector);
    return console.log(property);
  };
  return {
    init: function() {
      initProperty('#registration-form-name', user.name);
      $('#registration-form-name').on("focus keyup paste", function() {
        user.name.value = $(this).val();
        user.name.validate();
        hide_other_guides();
        return $('#registration-form-name + .guidance').css('display', 'block').html("<p>" + user.name.guidance.title + "<br/>" + user.name.guidance.explanation + "</p>");
      });
      $('#registration-form-email').on("focus keyup paste", function() {
        user.email.value = $(this).val();
        user.email.validate();
        hide_other_guides();
        return $('#registration-form-email + .guidance').css('display', 'block').html("<p>" + user.email.guidance.title + "<br/>" + user.email.guidance.explanation + "</p>");
      });
      return $('#registration-form-password').on("focus keyup paste", function() {
        user.password.value = $(this).val();
        user.password.validate();
        hide_other_guides();
        return $('#registration-form-password + .guidance').css('display', 'block').html("<p>" + user.password.guidance.title + "<br/>" + user.password.guidance.explanation + "</p>");
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
