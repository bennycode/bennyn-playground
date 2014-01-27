# 1. login
# 2. get_conversations
# 3. get latest events

after_fetching_last_events = ->
  Zeta.Service.WebSocket.open_websocket()

after_fetching_conversations = ->
  # Empty conversation view model
  Zeta.Instances.MainViewModel.conversations.removeAll()
  # Fill conversation view model
  for id, conversation of Zeta.Storage.Session.get_conversations()
    Zeta.Instances.MainViewModel.conversations.push conversation
  Zeta.Service.Main.get_last_event_ids after_fetching_last_events

after_login = (data, textStatus, jqXHR) ->
  if textStatus is "error"
    Zeta.Instances.MainViewModel.conversation_intro "Login failed :("
  else
    Zeta.Instances.MainViewModel.conversation_intro "Login successful. Please click on a conversation."
    Zeta.Service.Main.get_conversations ->
      Zeta.Service.Main.get_names_for_all_conversations after_fetching_conversations

$(window).load ->
  # Init controllers
  conversation_controller = new Zeta.Controller.ConversationController()

  # Login
  $.ajax
    async: true,
    url: "data/login.properties"
  .done (data) ->
    credentials = data.split ":"
    email = credentials[0]
    password = credentials[1]
    Zeta.Service.Main.login email, password, after_login