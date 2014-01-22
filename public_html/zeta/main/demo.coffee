after_fetching_conversations = ->
  console.log Zeta.Storage.Session.list_conversations()
  for id, conversation of Zeta.Storage.Session.get_conversations()
    Zeta.Instances.MainViewModel.conversations.push conversation

after_login = ->
  Zeta.Service.Main.get_all_conversations_with_details after_fetching_conversations

Zeta.Service.Main.login "benny@wearezeta.com", "secret", after_login