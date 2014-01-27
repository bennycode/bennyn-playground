namespace Zeta:ViewModel:
  class MainViewModel
    constructor: (config) ->
      # Properties
      @conversation_input_text = ko.observable ""
      @conversation_intro = ko.observable "Please login..."
      @conversations = ko.observableArray []
      @conversation_messages = ko.observableArray []
      # Functions
      @send_knock = (conversation, event) =>
        callback = (data, textStatus, jqXHR) =>
          alert "HELLO!"
      
        Zeta.Service.Main.send_knock Zeta.Storage.Session.current_conversation_id, callback
        
      @send_hot_knock = (conversation, event) =>
        callback = (data, textStatus, jqXHR) =>
          alert "HEY!"
      
        Zeta.Service.Main.send_hot_knock Zeta.Storage.Session.current_conversation_id, callback        
      
      @send_message_to_conversation = (data, event) =>
        cid = Zeta.Storage.Session.current_conversation_id
        message = @conversation_input_text()
        callback = (data, textStatus, jqXHR) =>          
          console.log "Message sent to conversation"
          # Clear input field
          $('#conversation-input-text').val ''
            
        Zeta.Service.Main.post_message_to_conversation cid, message, callback
        
      @open_conversation = (conversation, event) =>
        @conversation_intro "<b>#{conversation.name}</b> (#{conversation.id})"
        Zeta.Storage.Session.current_conversation_id = conversation.id
      
        callback = (data, textStatus, jqXHR) =>
          @conversation_messages.removeAll()
          
          for event in data.events
            if event.type is Zeta.Model.EventTypes.Conversation.NEW_MESSAGE
              # Trigger: Fetch user information
              user = Zeta.Storage.Data.async_get_user_by_id event.from
              if user.name?
                @conversation_messages.push "#{user.name}: #{event.data.content}"
              else
                @conversation_messages.push "#{event.from}: #{event.data.content}"
              
        params =
          cid: conversation.id
          size: -20
          
        Zeta.Service.Main.get_latest_conversation_messages params, callback
        
    show_new_message: (conversation, event) =>
      if conversation.id is Zeta.Storage.Session.current_conversation_id
        user = Zeta.Storage.Data.async_get_user_by_id event.from
        if user.name?
          @conversation_messages.push "#{user.name}: #{event.data.content}"
        else
          @conversation_messages.push "#{event.from}: #{event.data.content}"