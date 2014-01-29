Zeta = {} unless Zeta?
Zeta.ViewModel = {} unless Zeta.ViewModel?
Zeta.ViewModel.ConversationContent = (->
  # Private
  @set_intro_text = (text) ->
    Zeta.ViewModel.ConversationContent.conversation_intro text
  # Public (Note: Knockout bindings have to be public)
  conversations: ko.observableArray []  
  conversation_intro: ko.observable "Please login..."
  conversation_input_text: ko.observable ""
  conversation_messages: ko.observableArray []
  # Client input bindings
  send_message_to_conversation: (data, event) =>
    cid = Zeta.Storage.Session.current_conversation_id
    message = Zeta.ViewModel.ConversationContent.conversation_input_text()
    callback = (data, textStatus, jqXHR) =>          
      console.log "Message sent to conversation"
      # Clear input field
      $('#conversation-input-text').val ''
    Zeta.Service.Main.post_message_to_conversation cid, message, callback  
  send_knock: (conversation, event) =>
    callback = (data, textStatus, jqXHR) =>
      alert "HELLO!"
    Zeta.Service.Main.send_knock Zeta.Storage.Session.current_conversation_id, callback
  send_hot_knock: (conversation, event) =>
    callback = (data, textStatus, jqXHR) =>
      alert "HEY!"
    Zeta.Service.Main.send_hot_knock Zeta.Storage.Session.current_conversation_id, callback     
  show_new_message: (conversation, event) =>
    if conversation.id is Zeta.Storage.Session.current_conversation_id
      # TODO: Throw away "Zeta.Storage.Data"
      user = Zeta.Storage.Data.async_get_user_by_id event.from
      if user.name?
        Zeta.ViewModel.ConversationContent.conversation_messages.push "#{user.name}: #{event.data.content}"
      else
        Zeta.ViewModel.ConversationContent.conversation_messages.push "#{event.from}: #{event.data.content}"
  open_conversation: (conversation, event) =>
    @set_intro_text "<b>#{conversation.name}</b> (#{conversation.id})"
    # TODO: Storage access in view model... Should be done in controller
    Zeta.Storage.Session.current_conversation_id = conversation.id
    params =
      cid: conversation.id
      size: -20
    # TODO: Service call from view model... Should be done in controller
    Zeta.Service.Main.get_latest_conversation_messages params, (data, textStatus, jqXHR) ->
      # TODO: Call to own function without @... We have to find a better approach here
      Zeta.ViewModel.ConversationContent.conversation_messages.removeAll()
      for event in data.events
        if event.type is Zeta.Model.EventTypes.Conversation.NEW_MESSAGE
          # Trigger: Fetch user information
          user = Zeta.Storage.Data.async_get_user_by_id event.from
          if user.name?
            Zeta.ViewModel.ConversationContent.conversation_messages.push "#{user.name}: #{event.data.content}"
          else
            Zeta.ViewModel.ConversationContent.conversation_messages.push "#{event.from}: #{event.data.content}"
#
)()