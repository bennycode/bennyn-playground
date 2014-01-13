###
  Execution:
  Zeta.Registration.UserManagement.login("bennyn+test2@wearezeta.com", "123456")
###
Zeta.Registration.UserManagement = (->

  # TODO: Put URLs in a central place
  host = 'https://armada-test.z-infra.com'
  url =
    access: "#{host}/access"
    login: "#{host}/login"
    register: "#{host}/register"

  login: (login, password) ->
    payload = {
      password: password
    }
    
    if login.indexOf("@") is -1
      payload.login = login
    else
      payload.email = login
      
    on_response = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      
    Zeta.Registration.RequestHandler.post_json(
      url.login
      payload
      on_response
      on_response
    ) 
#
)()