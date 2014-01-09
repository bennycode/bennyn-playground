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
    return $(selector).on('focus keyup paste', function() {
      var guide_element;
      property.value = $(this).val();
      property.validate();
      hide_other_guides();
      guide_element = $("" + selector + " + .guidance");
      guide_element.css('display', 'block').html("<p>" + property.guidance.title + "<br/>" + property.guidance.explanation + "</p>");
      if (property.guidance.is_critical) {
        return guide_element.css('color', 'red');
      }
    });
  };
  return {
    init: function() {
      initProperty('#registration-form-name', user.name);
      initProperty('#registration-form-email', user.email);
      return initProperty('#registration-form-password', user.password);
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
