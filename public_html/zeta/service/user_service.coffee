###
  User Management API:
  https://docs.z-infra.com/dev-device-api/latest/reference/users.html 
###
Zeta = {} unless Zeta?
Zeta.Service = {} unless Zeta.Service?
Zeta.Service.UserService = (->

  ###
    @param {object} data Data is an object that contains:
    {id} id User ID, Example: "496d0d21-0b05-49b5-8087-de94f3465b7b" 
    @param {function} callback
  ###
  get_user_by_id: (data, callback) ->
    config = 
      url: Zeta.Service.URLs.get_user_by_id data.id
      type: 'GET'
      on_done:
        callback  

    Zeta.Utils.RequestHandler.send_request config

  ###
    @param {function} callback
  ###
  get_own_user: (callback) ->
    config = 
      url: Zeta.Service.URLs.self()
      type: 'GET'
      on_done:
        callback
      
    Zeta.Utils.RequestHandler.send_request config

  ###
    @param {object} data Data is an object that contains:
    {string} phone_number Phone number in E.164 format: "+491722290229" 
    @param {function} callback
  ###
  change_own_phone_number: (data, callback) ->
    console.log "= Zeta.Service.UserService.change_own_phone_number"

    config =
      url: Zeta.Service.URLs.change_own_phone_number
      type: 'PUT'
      data: 
        phone: data.phone_number
      on_done:
        callback
        
    Zeta.Utils.RequestHandler.send_json config

  ###
    @param {object} data Data is an object that contains:
    {string} login Example: "bennyn+test2@wearezeta.com"
    {string} password Example: "123456"
    @param {function} callback
  ###
  login: (data, callback) ->
    console.log "= Zeta.Service.UserService.login"
  
    payload = 
      password: data.password
    
    if data.login.indexOf("@") is -1
      payload.login = data.login
    else
      payload.email = data.login
      
    config =
      url: Zeta.Service.URLs.login
      type: 'POST'
      data: payload
      on_done:
        callback      
      
    Zeta.Utils.RequestHandler.send_json config
#
)()