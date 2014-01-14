###
  Test API (you might need an access token!):
  https://api-docs.z-infra.com/swagger/
  
  User API documentation:
  https://docs.z-infra.com/dev-device-api/latest/reference/users.html
###
Zeta.Registration.UserBuilder = (->
  host = 'https://armada-test.z-infra.com'

  url =
    access: "#{host}/access"
    login: "#{host}/login"
    register: "#{host}/register"
    
  user = new Zeta.Registration.User()
  is_released = true # Submit button is blocked (to avoid spamming)
    
  # INPUT CHECK
  init_property = (element, property) ->
    input_field = $('.input-field', element)
    input_field
    .on 'focus keyup paste', ->
      property.value = $(this).val()      
      property.validate()
      test_input_data()
    .on 'blur', ->
      if property.valid is false
        show_guidance(element, property)
        disable_other_input_fields input_field
      else
        hide_guidance(element)
        enable_other_input_fields()
        
  test_input_data = ->
    if user.has_valid_registration_data() is true
      enable_submit_button true
    else
      enable_submit_button false
      
  enable_submit_button = (enable) ->
    if enable is true
      is_released = true
      $('#registration-form button').attr 'class', 'pure-button pure-button-primary'
    else
      is_released = false
      $('#registration-form button').attr 'class', 'pure-button pure-button-disabled'
      
  # GUIDANCE
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
    
  hide_other_guides = ->
    $('.guidance').css('display', 'none')    

  # INPUT LOCKING
  enable_other_input_fields = ->
    $('#registration-form input').prop 'disabled', false;      
    
  disable_other_input_fields = (input_field) ->
    $('#registration-form input').not(input_field).prop 'disabled', true;    

  # INIT
  init: ->
    # Input fields
    init_property $('#property-user-name'), user.name
    init_property $('#property-user-email'), user.email
    init_property $('#property-user-password'), user.password
    # Submit button
    $('#registration-form button').on 'click', (event) ->
      event.preventDefault();
      # Release submit button on response!
      if user.has_valid_registration_data() is true
        if is_released is true
          enable_submit_button false
          
          # Called after "on_response" OR "on_error"
          on_complete = ->
            enable_submit_button true

          # Registration successful OR (!) response code 200
          on_response = (data, textStatus, jqXHR) ->
            newUser = data
            console.log "Registration successful:"
            console.log newUser.email
            on_complete()

          # Registration unsuccessful
          # TODO: Check status code 500 and display "Retry later"
          on_error = (data, textStatus, jqXHR) ->
            console.log "Error: " + JSON.stringify data
            message = data.responseJSON.message
            switch data.responseJSON.label
              when "bad-email"
                user.email.set_guidance true, message, ""
                show_guidance $('#property-user-email'), user.email
            on_complete()

          # Send registration request to the server
          Zeta.Registration.RequestHandler.post_json(
            url.register
            user.get_registration_payload()
            on_response
            on_error
          )      
    # Focus
    $('#registration-form-user-name').focus()
#
)()