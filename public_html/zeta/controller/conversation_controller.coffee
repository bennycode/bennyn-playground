Zeta = {} unless Zeta?
Zeta.Controller = {} unless Zeta.Controller?
Zeta.Controller.ConversationController = (->
  # Private
  on_new_message = (event) ->
    conversation = Zeta.Storage.Session.get_conversation event.conversation
    Zeta.ViewModel.ConversationList.highlight_conversation conversation
    Zeta.ViewModel.ConversationContent.show_new_message conversation, event
  # Public
  init: ->
    amplify.subscribe Zeta.Model.EventTypes.Conversation.NEW_MESSAGE, on_new_message
    
  set_conversation_title: (text) ->
    Zeta.ViewModel.ConversationContent.conversation_intro text
    
  update_conversation_list: (callback) ->
  
    after_fetching_conversations = ->
      Zeta.ViewModel.ConversationContent.conversations.removeAll()
      for id, conversation of Zeta.Storage.Session.get_conversations()
        Zeta.ViewModel.ConversationContent.conversations.push conversation                
      Zeta.Service.Main.get_last_event_ids callback
      
    Zeta.Service.Main.get_conversations ->
      Zeta.Service.Main.get_names_for_all_conversations after_fetching_conversations
#
)()

Zeta.Controller.ConversationController.init()