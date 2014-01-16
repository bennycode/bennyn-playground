###
  Public method structure:
  1. Logging*
  2. Data preparation*
  3. Config setup
  4. Service call
  *  optional
###
Zeta = {} unless Zeta?
Zeta.Service = {} unless Zeta.Service?
Zeta.Service.Main = (->

  ###
    Retrieves data of all conversations from the backend.
    If there is a UID (for a participant, a creator of a chat or sth. else)
    then this method tries to get also this information and to map it into
    objects.
    @param {function} callback
  ###
  get_all_conversations_with_details: (callback) ->
    Zeta.Service.Main.get_conversations ->
      Zeta.Service.Main.get_names_for_all_conversations callback

  ###
    @param {function} callback
  ### 
  get_names_for_all_conversations: (callback) ->
    console.log "= Zeta.Service.Main.get_names_for_all_conversations"
    conversations = Zeta.Storage.Session.get_conversations()
    
    # Detect unnamed conversations
    ajax_call = 0
    ajax_call_total = 0
    
    unnamed_conversations = {}
    for key, conversation of conversations
      if not conversation.name
        unnamed_conversations[key] = conversation
        ++ajax_call_total
    
    $.each unnamed_conversations, (index, conversation) ->
      # Set the conversation name and conversation creator for unnamed chats
      process_creator = (data, textStatus, jqXHR) ->
        ++ajax_call
        creator = new Zeta.Model.User()
        creator.init data
        
        conversation_to_update = Zeta.Storage.Session.get_conversation conversation.id
        conversation_to_update.creator = creator
        conversation_to_update.name = "Unnamed conversation with #{creator.name}"
        
        if ajax_call is ajax_call_total
          callback?()
        
      # If the conversation has no name, then take the creator's name
      # Always take our conversation partner's name, even if we instantiated the chat
      creator_id = conversation.creator
      if creator_id is Zeta.Storage.Session.get_user().id and conversation.has_participants
        creator_id = conversation.members.others[0].id
        # Request the conversation partner's name
      Zeta.Service.Main.get_user_by_id creator_id, process_creator 

  ###
    @param {function} callback
  ###          
  get_conversation_by_id: (id, callback) ->
    console.log "= Zeta.Service.Main.get_conversation_by_id"
    # Data
    data =
      id: id
    
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log "Received conversation: #{data.id}"
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.ConversationService.get_conversation_by_id data, on_done
    
  ###
    @param {string} id "d9440db8-752f-4c29-b173-af413fba9afa"
    @param {string} message "Hello World!"
    @param {function} callback
  ###          
  post_message_to_conversation: (id, message, callback) ->
    console.log "= Zeta.Service.Main.post_message_to_conversation"
    # Data
    data =
      id: id
      plain_message: message
    
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log data
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.ConversationService.post_message_to_conversation data, on_done    

  ###
    @param {function} callback
  ###          
  get_conversations: (callback) ->
    console.log "= Zeta.Service.Main.get_conversations"
    # Data
    # Callback
    handle_conversations = (conversations) ->
      for key, value of conversations
        conversation = new Zeta.Model.Conversation value
        Zeta.Storage.Session.add_conversation conversation.id, conversation
    
    on_done = (data, textStatus, jqXHR) ->
      handle_conversations data.conversations if data.conversations
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.ConversationService.get_conversations on_done

  ###
    @param {string} id User ID, Example: "0bb84213-8cc2-4bb1-9e0b-b8dd522396d5"
    @param {string} password Password of the user (plaintext!)
    @param {function} callback
  ###
  get_user_by_id: (id, callback) ->
    # console.log "= Zeta.Service.Main.get_user_by_id"
    # Data
    data =
      id: id
    
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.UserService.get_user_by_id data, on_done

  ###
    Updates the locally stored own user with the latest information from the backend.
    @param {function} callback
  ###
  update_own_user: (callback) ->
    console.log "= Zeta.Service.Main.update_user"
    # Data
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      user = new Zeta.Model.User()
      user.init data
      Zeta.Storage.Session.set_user user
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.UserService.get_own_user on_done
    
  ###
    @param {string} phone_number "01722290229"
    @param {string} country_code "DE"
    @param {function} callback
  ###
  change_own_phone_number: (phone_number, country_code, callback) ->
    console.log "= Zeta.Service.Main.change_own_phone_number"
    # Data
    phone_number_e164 = Zeta.Utils.Misc.convert_phone_number_to_e164(
      phone_number
      country_code
    )
    data =
      phone_number: phone_number_e164
    
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      
      if data.status is 202
        console.info "Phone number changed!"
        
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.UserService.change_own_phone_number data, on_done

  ###
    @param {string} login Email address of the user
    @param {string} password Password of the user (plaintext!)
    @param {function} callback
  ###
  login: (login, password, callback) ->
    console.log "= Zeta.Service.Main.login"
    # Data
    data =
      login: login
      password: password
    
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      if jqXHR.status is 200 and data.access_token?
        console.log "Login successful. Access Token:"
        console.log data.access_token
        
        login_session = new Zeta.Model.Login data.access_token
        Zeta.Storage.Session.set_login login_session
        Zeta.Service.Main.update_own_user callback
      else
        console.log "Authentication FAILED"        
    
    # Service
    Zeta.Service.UserService.login data, on_done
#
)()