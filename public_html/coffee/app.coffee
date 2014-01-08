# Prototype functions
Array::present = ->
  @.length > 0

class UserProperty
  constructor: (@value = '') ->
    @guidance = {
      level: 'error'
      title: 'guide.title'
      explanation: 'guide.explanation'
    }

  isValid: ->
    @value.length > 0

class UserPassword extends UserProperty
  constructor: (@value) ->

  isValid: =>
    @value.length > 5

class UserEmailAddress extends UserProperty
  emailPattern = /// ^ #begin of line
     ([\w.-]+)         #one or more letters, numbers, _ . or -
     @                 #followed by an @ sign
     ([\w.-]+)         #then one or more letters, numbers, _ . or -
     \.                #followed by a period
     ([a-zA-Z.]{2,6})  #followed by 2 to 6 letters or periods
     $ ///i            #end of line and ignore case
  constructor: (@value) ->

  isValid: ->
    if @value.match emailPattern
      true
    else
      false

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


###
  https://docs.z-infra.com/dev-device-api/latest/reference/users.html
###
Registration = (->

  host = 'https://armada-test.z-infra.com'

  url =
    access: host + '/access'
    login: host + '/login'
    register: host + '/register'

  user = new User("", "", "")

  init: ->
    $('#registration-form-name').on 'blur', ->
      user.name.value = $(this).val()
      console.log "Username: #{user.name.value} | valid: #{user.name.isValid()}"
      if not user.name.isValid()
        alert "username invalid"

    # TODO: Set focus into name field

  register: (user) ->
    if user.hasValidRegistrationData
      RequestHandler.postData(
        url.register,
        user.getRegistrationPayload(),
        (data, textStatus, jqXHR) ->
          alert JSON.stringify data
        (data, textStatus, jqXHR) ->
          alert JSON.stringify data
      )
)()

RequestHandler = (->
  postData: (url, data, onSuccess, onError) ->
    payload = data

    $.ajax url,
      type: 'POST'
      crossDomain: true,
      contentType: 'application/json; charset=utf-8'
      dataType: 'json'
      data: payload
      error: onError
      success: onSuccess
)()

pw = new UserPassword("abc123")

benny = new User('Benny', 'benny@wearezeta.com', 'abc123')
# alert benny.name.value
# alert benny.name.isValid()
# alert benny.hasValidRegistrationData()
# alert benny.getRegistrationPayload()
# alert benny.name.guidance.title

# Registration.register(benny)
Registration.init()

class window.Foo
  @foo = 'blah'
  console.log(@foo)

