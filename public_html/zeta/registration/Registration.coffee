Zeta.Registration.Registration = (->
  host = 'https://armada-test.z-infra.com'

  url =
    access: "#{host}/access"
    login: "#{host}/login"
    register: "#{host}/register"

  user = new Zeta.Registration.User()

  init: ->
    # Username
    $('#registration-form-name').on("keyup paste mousemove", ->
      user.name.value = $(this).val()
      user.name.validate()
      $('#registration-form-name + .guidance').html "<p>#{user.name.guidance.title}<br/>#{user.name.guidance.explanation}</p>"
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