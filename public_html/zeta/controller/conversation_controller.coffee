Zeta = {} unless Zeta?
Zeta.Controller = {} unless Zeta.Controller?
Zeta.Controller.ConversationController = (->
  # Private
  open_conversation = (conversation) ->
    # Update client state
    Zeta.Storage.Session.current_conversation_id = conversation.id
    # Update model
    params =
      cid: conversation.id
      size: -20
    
    # TODO: event / data parsing should be handled by the main service to
    # split view and model access
    after_fetching_latest_events = (data, textStatus, jqXHR) ->
      Zeta.ViewModel.ConversationContent.conversation_messages.removeAll()
      for event in data.events
        if event.type is Zeta.Model.EventTypes.Conversation.NEW_MESSAGE
          user = Zeta.Storage.Data.async_get_user_by_id event.from
          if user.name?
            Zeta.ViewModel.ConversationContent.conversation_messages.unshift "#{user.name}: #{event.data.content}"
          else
            Zeta.ViewModel.ConversationContent.conversation_messages.unshift "#{event.from}: #{event.data.content}"
    
    after_fetching_latest_event_ids = (data, textStatus, jqXHR) ->
      Zeta.Service.Main.get_latest_conversation_messages params, after_fetching_latest_events
      
    Zeta.Service.Main.get_last_event_ids after_fetching_latest_event_ids
    
    # Update view
    Zeta.ViewModel.ConversationContent.conversation_intro "<b>#{conversation.name}</b> (#{conversation.id})"
    
  on_new_message = (event) ->
    conversation = Zeta.Storage.Session.get_conversation event.conversation
    Zeta.ViewModel.ConversationList.highlight_conversation conversation
    Zeta.ViewModel.ConversationContent.show_new_message conversation, event
  # Public
  init: ->
    amplify.subscribe Zeta.Model.EventTypes.Conversation.NEW_MESSAGE, on_new_message
    amplify.subscribe Zeta.Model.EventTypes.View.OPEN_CONVERSATION, open_conversation
    
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