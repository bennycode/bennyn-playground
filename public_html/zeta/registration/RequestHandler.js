// Generated by CoffeeScript 1.6.3
(function() {
  Zeta.Registration.RequestHandler = (function() {
    return {
      postData: function(url, data, onSuccess, onError) {
        var payload;
        payload = data;
        return $.ajax(url, {
          type: 'POST',
          crossDomain: true,
          contentType: 'application/json; charset=utf-8',
          dataType: 'json',
          data: payload,
          error: onError,
          success: onSuccess
        });
      }
    };
  })();

}).call(this);

/*
//@ sourceMappingURL=RequestHandler.map
*/
