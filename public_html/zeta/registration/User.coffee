###
  https://docs.z-infra.com/dev-device-api/latest/reference/users.html
###

class User
  constructor: (name, email, password) ->
    @name = new UserProperty(name)
    @email = new UserEmailAddress(email)
    @password = new UserPassword(password)

  optional: (
    accent: []
    picture: []
    phone: ""
    phone_code: ""
  )

  getRegistrationPayload: =>
    payload = {}
    for key of @
      if @[key] instanceof UserProperty && @[key].isValid()
        payload[key] = @[key].value
    JSON.stringify payload

  hasValidRegistrationData: ->
    if @.name.isValid() && @.email.isValid() && @.password.isValid()
      true
    else
      false