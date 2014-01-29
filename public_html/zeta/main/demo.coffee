# Init
$(document).ready ->
  ko.applyBindings Zeta.ViewModel.ConversationContent, document.getElementById "conversation-list-grid"

# Start app
$(window).load ->
  # 2.Get conversation list
  after_login = (data, textStatus, jqXHR) ->
    if textStatus is "error"
      Zeta.Controller.ConversationController.set_conversation_title "Login failed :("
    else
      Zeta.Controller.ConversationController.set_conversation_title "Login successful. Please click on a conversation."
      Zeta.Controller.ConversationController.update_conversation_list ->
        Zeta.Service.WebSocket.open_websocket()

  # 1. Login
  login_file = "data/login.properties"
  
  if navigator.appVersion.indexOf('Trident/') > -1
    login_file = "data/login_internet_explorer.properties"
  else if navigator.appVersion.indexOf('Chrome/') > -1
    login_file = "data/login_chrome.properties"
  else
    login_file = "data/login_firefox.properties"

  $.ajax
    async: true,
    url: login_file
  .done (data) ->
    credentials = data.split ":"
    email = credentials[0]
    password = credentials[1]
    Zeta.Service.Main.login email, password, after_login