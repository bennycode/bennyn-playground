Zeta.Registration.UserBuilder = (->
  host = 'https://armada-test.z-infra.com'

  url =
    access: "#{host}/access"
    login: "#{host}/login"
    register: "#{host}/register"

  user = new Zeta.Registration.User()
  
  hide_other_guides = ->
    $('.guidance').css('display', 'none')
    
  initProperty = (selector, property) ->
    $(selector).on('focus keyup paste', ->
      # Input
      property.value = $(this).val()      
      property.validate()
      
      # Guidance
      hide_other_guides();
      
      guide_element = $("#{selector} + .guidance")
      
      guide_element
      .css('display', 'block')
      .html "<p>#{property.guidance.title}<br/>#{property.guidance.explanation}</p>"
      
      if property.guidance.is_critical
        guide_element.css('color', 'red')
    )

  init: ->
    initProperty('#registration-form-name', user.name)
    initProperty('#registration-form-email', user.email)
    initProperty('#registration-form-password', user.password)

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