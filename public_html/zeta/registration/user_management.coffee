###
  User Management API:
  https://docs.z-infra.com/dev-device-api/latest/reference/users.html
###
Zeta.Registration.UserManagement = (->
  # TODO: Put URLs in a central place
  host = 'https://armada-test.z-infra.com'
  url =
    access: "#{host}/access"
    login: "#{host}/login"
    register: "#{host}/register"
    self: "#{host}/self"
    
  expose = {
    login: {
      access_token: null
    }
  }
    
  ###
    Execution:
    Zeta.Registration.UserManagement.login("bennyn+test2@wearezeta.com", "123456")
  ###
  login: (login, password) ->
    payload = {
      password: password
    }
    
    if login.indexOf("@") is -1
      payload.login = login
    else
      payload.email = login
      
    on_success = (data, textStatus, jqXHR) ->
      console.log "Login successful"
      expose.login.access_token = data.access_token
      
    on_error = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data    
      
    Zeta.Registration.RequestHandler.post_json(
      url.login
      payload
      on_success
      on_error
    ) 

  ###
    - Get "access_token" from login
    - Attach "access_token" as a parameter to the URL that is called
    - Send a stringified JSON object with key "phone" and value phone number 
    (in E.164 format) as PUT request
    @see https://code.google.com/p/libphonenumber/
    
    Responses:
    - {"readyState":4,"responseText":"","status":202,"statusText":"Accepted"} 
    
    Execution:
    Zeta.Registration.UserManagement.change_own_phone_number("01722290229", "DE")
  ###
  change_own_phone_number: (phone_number, country_code) ->
    on_response = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      if data.status is 202
        console.info "Phone number changed!"
   
    data = {
      phone: Zeta.Registration.Utils.convert_phone_number_to_e164 phone_number, country_code
    }
    payload = JSON.stringify data
      
    $.ajax
      url: "#{host}/self/phone?access_token=" + expose.login.access_token
      type: 'PUT'
      crossDomain: true
      contentType: 'application/json; charset=utf-8'
      dataType: 'json'
      data: payload
    .done(on_response)
    .fail(on_response)
  
  # GETTERS
  getLogin: ->
    expose.login    
#
)()