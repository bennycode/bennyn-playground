###
  User Management API:
  https://docs.z-infra.com/dev-device-api/latest/reference/users.html 
###
Zeta = {} unless Zeta?
Zeta.Service = {} unless Zeta.Service?
Zeta.Service.UserService = (->
  #
  login: (values, callback) ->
    data =
      "expires_in": 3600,
      "access_token": "491c44e0c90417aa0f60caa58497ec9c70c9699f10c2162069ef75df74695ec5.1.1391013086.a.cbc314d5-a84f-4ee7-bf56-373705cbffa5.17491614023395015869",
      "token_type": "Bearer"
    
    textStatus = "success"
    
    jqXHR =
      status: 200

    callback data, textStatus, jqXHR

  #
  get_own_user: (callback) ->
    data =
      email: "jon+doe@wearezeta.com"
      phone: null
      accent: [0.14100000262260437, 0.5519999861717224, 0.8270000219345093, 1]
      accent_id: 0
      picture: []
      name: "Jon Doe"
      id: "cbc314d5-a84f-4ee7-bf56-373705cbffa5"

    textStatus = "success"
    
    jqXHR =
      status: 200

    callback data, textStatus, jqXHR

#
)()