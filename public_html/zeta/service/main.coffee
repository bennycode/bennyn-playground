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
  # Private
  self =
    create_user_id_string: (user_ids) ->
      user_id_collection = ""
      for user_id in user_ids
        user_id_collection += "#{user_id},"
      user_id_string = user_id_collection.substr 0, user_id_collection.length - 1    

  ###
    Retrieves data of all conversations from the backend.
    If there is a UID (for a participant, a creator of a chat or sth. else)
    then this method tries to get also this information and to map it into
    objects.
    @param {function} callback
  ###
  get_all_conversations_with_details: (callback) ->
    on_done = (data, textStatus, jqXHR) ->
      callback?(data, textStatus, jqXHR)
      
    Zeta.Service.Main.get_conversations ->
      Zeta.Service.Main.get_names_for_all_conversations callback

  ###
    @param {string} email
    @param {function} callback
  ###
  initiate_password_reset: (email, callback) ->
    console.log "= Zeta.Service.Main.initiate_password_reset"
    # Data
    if not email
      email = Zeta.Storage.Session.get_user().email
    
    values =
      data:
        email: email
    
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      # {"readyState":4,"responseText":"","status":201,"statusText":"Created"}
      # TODO: Status code 409 if reset has been already requested
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.UserService.initiate_password_reset values, on_done     
  
  get_own_connections: (callback) ->
    console.log "= Zeta.Service.Main.get_own_connections"
   
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.UserService.get_own_connections on_done   
  
  ###
    Sends a knock ("Hello").
    
    @param {string} cid Conversation ID "f9f764a4-5592-4a4f-88c3-a55c083df855"
    @param {function} callback
  ###
  send_knock: (cid, callback) ->
    console.log "= Zeta.Service.Main.send_knock"
    # Data
    values =
      cid: cid
      data:
        content: ""
        nonce: UUID.genV4().hexString
        
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.ConversationService.send_knock values, on_done  
    
  ###
    Sends a hot knock ("Hey").
  
    @param {string} cid Conversation ID "f9f764a4-5592-4a4f-88c3-a55c083df855"
    @param {function} callback
  ###
  send_hot_knock: (cid, callback) ->
    console.log "= Zeta.Service.Main.send_hot_knock"
    # Data
    values =
      cid: cid
      data:
        content: ""
        nonce: UUID.genV4().hexString
        
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.ConversationService.send_hot_knock values, on_done      
  
  ###
    Date time format: ISO 8601
    "2014-01-21T16:31:13.090Z"
  ###
  create_connection: (to_uuid, callback) ->
    console.log "= Zeta.Service.Main.create_connection"
    # Data
    values =
      data:
        # TODO: Some parameters are missing...
        from: Zeta.Storage.Session.get_user().id
        to: to_uuid        
        last_update: new Date().toJSON()
    
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.UserService.create_connection values, on_done        
  
  ###
    @param {string} uid "a46ffc68-cb0e-45c1-bff8-13c4db065aa7"
    @param {function} callback
  ###
  is_existing_user: (uid, callback) ->
    console.log "= Zeta.Service.Main.is_existing_user"
    # Data
    values =
      uid: uid
      
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      if jqXHR.status is 200
        console.log "Valid user ID"
      else
        console.log "Invalid user ID"
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.UserService.is_existing_user values, on_done       
  
  ###
    @param {string} name
    @param {function} callback    
  ###
  update_name: (name, callback) ->
    console.log "= Zeta.Service.Main.update_user_profile"
    # Data
    values =
      data:
        name: name
        
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.UserService.update_user_profile values, on_done  
    
  ###
    @param {array} accent_color
    @param {function} callback    
  ###
  update_accent_color: (accent_color, callback) ->
    console.log "= Zeta.Service.Main.update_accent_color"
    # Data
    values =
      data:
        accent: accent_color
        
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.UserService.update_user_profile values, on_done  
    
  ###
    @param {Asset} picture
    @param {function} callback    
  ###
  update_picture: (picture, callback) ->
    console.log "= Zeta.Service.Main.update_picture"
    # Data
    values =
      data:
        picture: picture
        
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.UserService.update_user_profile values, on_done    
  
  ###
    Note: Rename every conversation except type "0" conversations!
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
        if conversation.members.others.length > 0
          unnamed_conversations[key] = conversation
          ++ajax_call_total
        else
          conversation_to_update = Zeta.Storage.Session.get_conversation conversation.id
          conversation_to_update.name = "Self conversation"
    
    if ajax_call_total is 0
      callback?()
    else
      # Set the conversation name and conversation creator for unnamed chats
      $.each unnamed_conversations, (index, conversation) ->
        # 2. Callback for each conversation request
        process_creators = (data, textStatus, jqXHR) ->
          ++ajax_call

          # 3. Update chat name, ex.
          # Chat with Björn Herbig, Andreas Kompanez, Kenny
          chat_name = "Chat with "

          for item in data
            chat_name += item.name + ", "

          chat_name = chat_name.slice 0, -2
          conversation_to_update = Zeta.Storage.Session.get_conversation conversation.id
          conversation_to_update.name = chat_name

          # 4. Execute final callback after all requests have been made
          if ajax_call is ajax_call_total
            callback?()

        # 1. Collect the IDs for every participant and query it
        uids_of_participants = []
        for k, v of conversation.members.others
          uids_of_participants.push v.id

        Zeta.Service.Main.get_users uids_of_participants, process_creators 

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
      console.log JSON.stringify data
      conversation = new Zeta.Model.Conversation data
      conversation.log_name()
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
    Gets a set of conversation messages.
    TODO: It does not get the LATEST message. 
    
    Example: In a conversation with 49 messages it stops at message 48.
    We have to check if this is a backend problem or a frontend problem.
    
    @param {function} callback
  ###          
  get_latest_conversation_messages: (params, callback) ->
    console.log "= Zeta.Service.Main.get_latest_conversation_messages"
    if typeof params isnt 'object'
      console.log "Please provide an object"
      return
    
    # Data
    values =
      id: params.cid
      data:
        start: Zeta.Storage.Session.get_conversation(params.cid).last_event
        end: "0.0"
        size: params.size
      
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.ConversationService.get_conversation_messages values, on_done
    
  ###
    @param {function} callback
  ###          
  get_conversation_messages: (id, callback) ->
    console.log "= Zeta.Service.Main.get_conversation_messages"
    # Data
    values =
      id: id
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      for k, message of data.messages
        console.log JSON.stringify message.data.content
        # TODO: Also read message.data.contents if "content" does not exist
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.ConversationService.get_conversation_messages values, on_done

  ###
    Zeta.Service.Main.get_users(["0bb84213-8cc2-4bb1-9e0b-b8dd522396d5","15ede065-72b3-433a-9917-252f076ed031"])
    
    @param {array} user_ids Array with User IDs, Example: ["0bb84213-8cc2-4bb1-9e0b-b8dd522396d5","15ede065-72b3-433a-9917-252f076ed031"]
    @param {function} callback
  ###
  get_users: (user_ids, callback) ->
    console.log "= Zeta.Service.Main.get_users"
    if not user_ids.length
      return
    
    # Data
    values =
      data:
        ids: self.create_user_id_string user_ids
      
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      if textStatus is "success"
        for item in data
          user = new Zeta.Model.User item
          Zeta.Storage.Session.add_user user
      else
        console.log "get_users: Cannot fetch user information"
      callback?(data, textStatus, jqXHR)

    # Service
    Zeta.Service.UserService.get_users values, on_done
  
  ###
    @param {array} user_ids Array with User IDs, Example: ["0bb84213-8cc2-4bb1-9e0b-b8dd522396d5","15ede065-72b3-433a-9917-252f076ed031"]
    @param {string} name Name of the conversation
    @param {function} callback
  ###
  create_conversation: (user_ids, name, callback) ->
    console.log "= Zeta.Service.Main.create_conversation"
    
    # Data
    values =
      data:
        users: user_ids
        name: name
    
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      
    # Service
    Zeta.Service.ConversationService.create_conversation values, on_done

  ###
    @param {array} user_ids Array with User IDs, Example: ["0bb84213-8cc2-4bb1-9e0b-b8dd522396d5","15ede065-72b3-433a-9917-252f076ed031"]
    @param {string} name Name of the conversation
    @param {function} callback
  ###
  create_one_to_one_conversation: (user_ids, name, callback) ->
    console.log "= Zeta.Service.Main.create_one_to_one_conversation"
    
    # Data
    values =
      data:
        users: user_ids
        name: name
        
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      
    # Service
    Zeta.Service.ConversationService.create_one_to_one_conversation values, on_done  

  create_self_conversation: (callback) ->
    console.log "= Zeta.Service.Main.create_self_conversation"
    
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      
    # Service
    Zeta.Service.ConversationService.create_self_conversation on_done

  ###
    @param {string} id Conversation ID "f9f764a4-5592-4a4f-88c3-a55c083df855"
    @param {array} user_ids Array with User IDs, Example: ["0bb84213-8cc2-4bb1-9e0b-b8dd522396d5","15ede065-72b3-433a-9917-252f076ed031"]    
    @param {function} callback    
  ###
  add_users_to_conversation: (id, user_ids, callback) ->
    console.log "= Zeta.Service.Main.add_users_to_conversation"
    
    # Data
    values =
      id: id
      data:
        users: user_ids
    
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      callback?(data, textStatus, jqXHR)
        
    # Service
    Zeta.Service.ConversationService.add_users_to_conversation values, on_done    

  ###
    Get the IDs of the last events for every active conversation that you have.
    This is useful to display if there have been any new messages.
  ###
  get_last_event_ids: (callback) ->
    console.log "= Zeta.Service.Main.get_last_events"
    
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      if textStatus is "success"
        for item in data.conversations
          cid = item.id
          eid = item.event
          Zeta.Storage.Session.update_conversation_last_event_id cid, eid
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.ConversationService.get_last_events on_done
  
  ###
    TODO: Check if the key is encoded correctly!!
    
    @param {string} key The activation key is a URL-safe-base64-encoded SHA256 of the key being activated (an e-mail address or a phone number).
    @param {string} code The random, generated code associated with the key that is only communicated out-of-band, i.e. via e-mail or SMS.
  ###
  validate_activation_code: (key, code) ->
    console.log "= Zeta.Service.Main.validate_activation_code"
    
    # Data
    values =
      key: encodeURIComponent(Zeta.Utils.Misc.encode_base64 Zeta.Utils.Misc.encode_sha256 key)
      code: code
      
    # Callback
    on_done = (data, textStatus, jqXHR) ->      
      console.log JSON.stringify data     
      if jqXHR.status is 200
        console.log "The key/code combination exists / is valid."
      else
        console.log "The key/code combination does not exist."
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.UserService.validate_activation_code values, on_done   
    
  use_activation_code: (key, code) ->
    console.log "= Zeta.Service.Main.use_activation_code"
    
    # Data
    values =
      data:
        key: Zeta.Utils.Misc.encode_base64(Zeta.Utils.Misc.encode_sha256 key)
        code: code
      
    # Callback
    on_done = (data, textStatus, jqXHR) ->      
      console.log JSON.stringify data     
      if jqXHR.status is 200
        console.log "Activation was successful."
      else
        console.log "The key/code combination does not exist."
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.UserService.use_activation_code values, on_done      
  
  ###
    @param {string} cid Conversation ID "f9f764a4-5592-4a4f-88c3-a55c083df855"
    @param {string} uid User ID "b5ac5b2c-23ab-408a-b652-70317686c58b"
    @param {function} callback    
  ###
  remove_user_from_conversation: (cid, uid, callback) ->
    console.log "= Zeta.Service.Main.remove_user_from_conversation"
    
    # Data
    values =
      cid: cid
      uid: uid   
    
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      callback?(data, textStatus, jqXHR)
        
    # Service
    Zeta.Service.ConversationService.remove_user_from_conversation values, on_done      
    
  update_conversation_properties: (id, name, callback) ->
    console.log "= Zeta.Service.Main.update_conversation_properties"
      
    # Data
    values =
      id: id
      data:
        name: name
          
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      callback?(data, textStatus, jqXHR)
      
    # Service
    Zeta.Service.ConversationService.update_conversation_properties values, on_done      
  
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
      if textStatus is "success"
        user = new Zeta.Model.User data
        Zeta.Storage.Session.add_user user
      callback?(user)
      
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
      user = new Zeta.Model.User data
      Zeta.Storage.Session.set_user user
      Zeta.Storage.Session.add_user user
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
        # Zeta.Service.Main.update_own_user callback
      else
        console.log "Authentication FAILED"    
      
      Zeta.Service.Main.update_own_user callback
    
    # Service
    Zeta.Service.UserService.login data, on_done
#
)()