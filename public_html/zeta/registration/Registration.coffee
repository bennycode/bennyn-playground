Zeta.Registration.Registration = (->
  host = 'https://armada-test.z-infra.com'

  url =
    access: '#{host}/access'
    login: '#{host}/login'
    register: '#{host}/register'

  user = new Zeta.Registration.User()

  init: ->
    # Username
    $('#registration-form-name').on('blur', ->
      user.name.value = $(this).val()
      console.log "Username: #{user.name.value} | valid: #{user.name.is_valid()}"

      if not user.name.is_valid()
        console.log "username invalid"

      # TODO: Set focus into username field
    )

  register: (user) ->
    if user.has_valid_registration_data
      Zeta.Registration.RequestHandler.postData(
        url.register
        user.get_registration_payload()
        (data, textStatus, jqXHR) ->
          console.log "Registration successful"
          console.log JSON.stringify data
        (data, textStatus, jqXHR) ->
          console.log "Registration failed"
          console.log JSON.stringify data
      ))()