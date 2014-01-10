Zeta.Registration.UserBuilder = (->
  host = 'https://armada-test.z-infra.com'

  url =
    access: "#{host}/access"
    login: "#{host}/login"
    register: "#{host}/register"

  user = new Zeta.Registration.User()
  
  hide_other_guides = ->
    $('.guidance').css('display', 'none')      
    
  disable_other_input_fields = (selector) ->
    $('#registration-form input').not(selector).prop 'disabled', true;
    
  enable_other_input_fields = ->
    $('#registration-form input').prop 'disabled', false;
    
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
      
      if property.guidance.is_critical and property.valid is false
        disable_other_input_fields(selector)
        guide_element.css('color', 'red')
      else
        enable_other_input_fields()
        
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