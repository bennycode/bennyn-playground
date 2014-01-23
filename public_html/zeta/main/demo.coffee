# 1. login
# 2. get_conversations

after_fetching_conversations = ->
  # Empty conversation VM
  Zeta.Instances.MainViewModel.conversations.removeAll()
  # Fill conversation VM
  for id, conversation of Zeta.Storage.Session.get_conversations()
    Zeta.Instances.MainViewModel.conversations.push conversation

after_login = (data, textStatus, jqXHR) ->
  console.log "CALLBACK!"
  if textStatus is "error"
    Zeta.Instances.MainViewModel.conversation_intro "Login failed :("
  else
    Zeta.Instances.MainViewModel.conversation_intro "Login successful. Please click on a conversation."
    Zeta.Service.Main.get_conversations ->
      Zeta.Service.Main.get_names_for_all_conversations after_fetching_conversations

$(window).load ->
  $.ajax
    async: true,
    url: "data/login.properties"
  .done (data) ->
    credentials = data.split ":"
    email = credentials[0]
    password = credentials[1]
    Zeta.Service.Main.login email, password, after_login