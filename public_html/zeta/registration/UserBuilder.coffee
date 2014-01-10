Zeta.Registration.UserBuilder = (->
  host = 'https://armada-test.z-infra.com'

  url =
    access: "#{host}/access"
    login: "#{host}/login"
    register: "#{host}/register"

  user = new Zeta.Registration.User()
  
  hide_other_guides = ->
    $('.guidance').css('display', 'none')      
    
  disable_other_input_fields = (input_field) ->
    $('#registration-form input').not(input_field).prop 'disabled', true;
    
  enable_other_input_fields = ->
    $('#registration-form input').prop 'disabled', false;      
    
  show_guidance = (element, property) ->
    guidance_dot = $('.guidance-dot', element)
    guidance_message = $('.guidance-message', element)
    input_container = $('.input-container', element)
    
    guidance_message.css 'display', 'block'    
    guidance_message.html "<p>#{property.guidance.title}<br/>#{property.guidance.explanation}</p>"
    
    if property.guidance.is_critical
      guidance_dot.addClass 'error'
      input_container.addClass 'error'
    else
      guidance_dot.addClass 'warning'
      input_container.addClass 'warning'
    
  hide_guidance = (element) ->
    guidance_dot = $('.guidance-dot', element)
    guidance_message = $('.guidance-message', element)
    input_container = $('.input-container', element)
    
    guidance_dot.removeClass 'warning error'
    guidance_message.css 'display', 'none'
    input_container.removeClass 'error warning'
    
  init_property = (element, property) ->
    input_field = $('.input-field', element)
    input_field
    .on 'focus keyup paste', ->
      property.value = $(this).val()      
      property.validate()
    .on 'blur', ->
      if property.valid is false
        show_guidance(element, property)
        disable_other_input_fields input_field
      else
        hide_guidance(element)
        enable_other_input_fields()

  init: ->
    init_property($('#property-user-name'), user.name)
    init_property($('#property-user-email'), user.email)
    init_property($('#property-user-password'), user.password)
    # TODO: Guidance message for password
    
    $('#registration-form-user-name').focus()

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