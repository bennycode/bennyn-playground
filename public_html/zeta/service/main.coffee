Zeta = {} unless Zeta?
Zeta.Service = {} unless Zeta.Service?
Zeta.Service.Main = (->

  update_user: (callback) ->
    console.log "= Zeta.Service.Main.update_user"
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
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      
      if data.status is 202
        console.info "Phone number changed!"
        
      callback?()
      
    # Service
    phone_number_e164 = Zeta.Utils.Misc.convert_phone_number_to_e164(
      phone_number
      country_code
    )
    Zeta.Service.UserService.change_own_phone_number phone_number_e164, on_done

  login: (login, password, callback) ->
    console.log "= Zeta.Service.Main.login"
    # Callback
    on_done = (data, textStatus, jqXHR) ->
      if jqXHR.status is 200 and data.access_token?
        console.log "Login successful. Access Token:"
        console.log data.access_token
        
        login = new Zeta.Model.Login(data.access_token)
        Zeta.Storage.Session.set_login(login)
        Zeta.Service.Main.update_user(callback)
      else
        console.log "Authentication FAILED"        
    
    # Service
    Zeta.Service.UserService.login login, password, on_done
#
)()