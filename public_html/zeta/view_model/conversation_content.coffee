Zeta = {} unless Zeta?
Zeta.ViewModel = {} unless Zeta.ViewModel?
Zeta.ViewModel.ConversationContent = (->
  # Private
  @input_text = ko.observable "Type sth."
  @intro_text = ko.observable "Please login..."
  @messages = ko.observableArray []
  # TODO: Move this to the conversation controller!
  @send_knock = (conversation, event) =>
    callback = (data, textStatus, jqXHR) =>
      alert "HELLO!"
    Zeta.Service.Main.send_knock(
      Zeta.Storage.ClientState.get_current_conversation_id(), 
      callback  
    )
  # TODO: Move this to the conversation controller!
  @send_hot_knock = (conversation, event) =>
    callback = (data, textStatus, jqXHR) =>
      alert "HEY!"
    Zeta.Service.Main.send_hot_knock(
      Zeta.Storage.ClientState.get_current_conversation_id(), 
      callback  
    )    
  # Setters
  set_intro_text: (value) =>
    @intro_text = value
  # Getters
  get_intro_text: =>
    @intro_text
  # Public
  remove_all_messages: =>
    @messages.removeAll()
  
  update_title: (conversation) =>
    @intro_text = "<b>#{conversation.name}</b> (#{conversation.id})"
  
  show_new_message: (conversation, event) =>
    if conversation.id is Zeta.Storage.ClientState.get_current_conversation_id()
      user = Zeta.Storage.Data.async_get_user_by_id event.from
      if user.name?
        @messages.push "#{user.name}: #{event.data.content}"
      else
        @messages.push "#{event.from}: #{event.data.content}"
#
)()