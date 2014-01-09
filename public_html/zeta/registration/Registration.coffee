Zeta.Registration.Registration = (->
  host = 'https://armada-test.z-infra.com'

  url =
    access: "#{host}/access"
    login: "#{host}/login"
    register: "#{host}/register"

  user = new Zeta.Registration.User()

  init: ->
    # Username
    $('#registration-form-name').on("focus keyup paste", ->
      user.name.value = $(this).val()
      user.name.validate()
      $('#registration-form-name + .guidance').html "<p>#{user.name.guidance.title}<br/>#{user.name.guidance.explanation}</p>"
    )
    
    # Email
    $('#registration-form-email').on("focus keyup paste", ->
      user.email.value = $(this).val()
      user.email.validate()
      $('#registration-form-email + .guidance').html "<p>#{user.email.guidance.title}<br/>#{user.email.guidance.explanation}</p>"
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