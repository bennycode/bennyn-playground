Zeta.Registration.Registration = (->

  host = 'https://armada-test.z-infra.com'

  url =
    access: host + '/access'
    login: host + '/login'
    register: host + '/register'

  user = new Zeta.Registration.User("", "", "")

  init: ->
    $('#registration-form-name').on 'blur', ->
      user.name.value = $(this).val()
      console.log "Username: #{user.name.value} | valid: #{user.name.isValid()}"
      if not user.name.isValid()
        alert "username invalid"

  # TODO: Set focus into name field

  register: (user) ->
    if user.hasValidRegistrationData
      Zeta.Registration.RequestHandler.postData(
        url.register,
        user.getRegistrationPayload(),
      (data, textStatus, jqXHR) ->
        alert JSON.stringify data
        (data, textStatus, jqXHR) ->
          alert JSON.stringify data
      )
)()