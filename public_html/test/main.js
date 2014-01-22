$(window).load(function() {

  function ViewModel() {
    var self = this;
    self.conversations = ko.observableArray([
      {"name": "Benny", "link": "one.html"},
      {"name": "two", "link": "two.html"}
    ]);
  }

  window.view_model_instance = new ViewModel();
  var element = document.getElementById('conversation-list');
  ko.applyBindings(window.view_model_instance, element);
  view_model_instance.conversations.push({"name":"Daniel"});
  // view_model_instance.conversations.peek()[0].name // Benny

});