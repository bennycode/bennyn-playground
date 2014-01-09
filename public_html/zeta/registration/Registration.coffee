# TODO: Rename to UserBuilder
Zeta.Registration.Registration = (->
  host = 'https://armada-test.z-infra.com'

  url =
    access: "#{host}/access"
    login: "#{host}/login"
    register: "#{host}/register"

  user = new Zeta.Registration.User()
  
  hide_other_guides = ->
    $('.guidance').css('display', 'none')
    
  initProperty = (selector, property) ->
    console.log selector
    console.log property

  init: ->
    initProperty('#registration-form-name', user.name)
  
    # Username
    $('#registration-form-name').on("focus keyup paste", ->
      # Input
      user.name.value = $(this).val()      
      user.name.validate()
      
      # Guidance
      hide_other_guides();      
      $('#registration-form-name + .guidance')
      .css('display', 'block')
      .html "<p>#{user.name.guidance.title}<br/>#{user.name.guidance.explanation}</p>"
    )
    
    # Email
    $('#registration-form-email').on("focus keyup paste", ->
      # Input
      user.email.value = $(this).val()
      user.email.validate()
      
      # Guidance
      hide_other_guides();
      $('#registration-form-email + .guidance')
      .css('display', 'block')
      .html "<p>#{user.email.guidance.title}<br/>#{user.email.guidance.explanation}</p>"
    )
    
    # Password
    $('#registration-form-password').on("focus keyup paste", ->
      # Input
      user.password.value = $(this).val()
      user.password.validate()
      
      # Guidance
      hide_other_guides();
      $('#registration-form-password + .guidance')
      .css('display', 'block')
      .html "<p>#{user.password.guidance.title}<br/>#{user.password.guidance.explanation}</p>"
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