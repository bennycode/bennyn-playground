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

  get_conversations: (callback) ->
    console.log "= Zeta.Service.Main.get_conversations"
    # Data
    # Callback
    handle_conversations = (conversations) ->
      for key, value of conversations
        conversation = new Zeta.Model.Conversation value
        Zeta.Storage.Session.add_conversation key, conversation
    
    on_done = (data, textStatus, jqXHR) ->
      handle_conversations data.conversations if data.conversations
      callback?()
      
    # Service
    Zeta.Service.ConversationService.get_conversations on_done

  get_user_by_id: (id, callback) ->
    console.log "= Zeta.Service.Main.get_user_by_id"
    # Data
    data =
      id: id
    
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      callback?()
      
    # Service
    Zeta.Service.UserService.get_user_by_id data, on_done

  update_user: (callback) ->
    console.log "= Zeta.Service.Main.update_user"
    # Data
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      user = new Zeta.Model.User()
      user.init(data)
      Zeta.Storage.Session.set_user(user)
      callback?()
      
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
        
      callback?()
      
    # Service
    Zeta.Service.UserService.change_own_phone_number data, on_done

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
        
        login_session = new Zeta.Model.Login(data.access_token)
        Zeta.Storage.Session.set_login(login_session)
        Zeta.Service.Main.update_user(callback)
      else
        console.log "Authentication FAILED"        
    
    # Service
    Zeta.Service.UserService.login data, on_done
#
)()