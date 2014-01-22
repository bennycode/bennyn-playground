namespace Zeta:ViewModel:
  class MainViewModel
    constructor: (config) ->
      @conversation_intro = ko.observable 'Please login...'
      @conversations = ko.observableArray []