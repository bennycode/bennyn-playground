Zeta.Registration.RequestHandler = (function() {
  return {
    postData: function(url, data, onSuccess, onError) {
      return $.ajax({
        url: url,
        type: 'POST',
        crossDomain: true,
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        data: data,
        error: onError,
        success: onSuccess
      });
    }
  };
})();
