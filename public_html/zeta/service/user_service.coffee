###
  User Management API:
  https://docs.z-infra.com/dev-device-api/latest/reference/users.html
###
Zeta = {} unless Zeta?
Zeta.Service = {} unless Zeta.Service?
Zeta.Service.UserService = (->
  ###
    @param {string} phone_number Phone number in E.164 format: "+491722290229" 
    @param {function} callback
  ###
  change_own_phone_number: (phone_number, callback) ->
    console.log "= Zeta.Service.UserService.change_own_phone_number"

    config =
      url: Zeta.Service.URLs.change_own_phone_number Zeta.Storage.Session.get_access_token()
      type: 'PUT'
      data: 
        phone: phone_number
      on_done:
        callback
        
    Zeta.Utils.RequestHandler.send_json config

  ###
    @param {string} login Example: "bennyn+tester@wearezeta.com"
    @param {string} password Example: "123456"
    @param {function} callback
  ###
  login: (login, password, callback) ->
    console.log "= Zeta.Service.UserService.login"
  
    payload = 
      password: password
    
    if login.indexOf("@") is -1
      payload.login = login
    else
      payload.email = login
      
    config =
      url: Zeta.Service.URLs.login
      type: 'POST'
      data: payload
      on_done:
        callback      
      
    Zeta.Utils.RequestHandler.send_json config
#
)()