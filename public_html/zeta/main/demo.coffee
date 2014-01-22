after_fetching_conversations = ->
  # Empty conversation VM
  Zeta.Instances.MainViewModel.conversations.removeAll()
  # Fill conversation VM
  for id, conversation of Zeta.Storage.Session.get_conversations()
    Zeta.Instances.MainViewModel.conversations.push conversation

after_login = (data, textStatus, jqXHR) ->
  if textStatus is "error"
    Zeta.Instances.MainViewModel.conversation_intro "Login failed :("
  else
    Zeta.Instances.MainViewModel.conversation_intro "Login successful. Please click on a conversation."
    Zeta.Service.Main.get_all_conversations_with_details after_fetching_conversations

Zeta.Service.Main.login "benny@wearezeta.com", "", after_login