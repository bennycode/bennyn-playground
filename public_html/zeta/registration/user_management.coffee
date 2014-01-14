###
  User Management API:
  https://docs.z-infra.com/dev-device-api/latest/reference/users.html
###
Zeta.Registration.UserManagement = (->
  # TODO: Put URLs in a central place
  host = 'https://armada-test.z-infra.com'
  url =
    access: "#{host}/access"
    login: "#{host}/login"
    register: "#{host}/register"
    self: "#{host}/self"
    
  expose = {
    login: {
      access_token: null
    }
    conversations: {
    }
  }
    
  ###
    Execution:
    Zeta.Registration.UserManagement.login("bennyn+test2@wearezeta.com", "123456")
  ###
  login: (login, password) ->
    payload = {
      password: password
    }
    
    if login.indexOf("@") is -1
      payload.login = login
    else
      payload.email = login
      
    on_success = (data, textStatus, jqXHR) ->
      expose.login.access_token = data.access_token
      console.info "Login successful. Access Token:"
      console.info expose.login.access_token
      
    on_error = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data    
      
    Zeta.Registration.RequestHandler.post_json(
      url.login
      payload
      on_success
      on_error
    ) 

  ###
    - Get "access_token" from login
    - Attach "access_token" as a parameter to the URL that is called
    - Send a stringified JSON object with key "phone" and value phone number 
    (in E.164 format) as PUT request
    @see https://code.google.com/p/libphonenumber/
    
    Responses:
    - {"readyState":4,"responseText":"","status":202,"statusText":"Accepted"} 
    
    Execution:
    Zeta.Registration.UserManagement.change_own_phone_number("01722290229", "DE")
  ###
  change_own_phone_number: (phone_number, country_code) ->
  
    on_response = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
      if data.status is 202
        console.info "Phone number changed!"
   
    data = {
      phone: Zeta.Registration.Utils.convert_phone_number_to_e164 phone_number, country_code
    }
      
    $.ajax
      url: "#{host}/self/phone?access_token=#{expose.login.access_token}"
      type: 'PUT'
      crossDomain: true
      contentType: 'application/json; charset=utf-8'
      dataType: 'json'
      data: JSON.stringify data
    .done(on_response)
    .fail(on_response)
  
  # GETTERS
  get_login: ->
    expose.login        
    
  get_conversations: ->
  
    on_response = (data, textStatus, jqXHR) ->    
      conversations = {}
      # TODO:
      # Map the conversation, the creator and all members into objects      
      for key, conversation of data.conversations
        expose.conversations[conversation.id] = 
        new Zeta.Conversations.Conversation conversation.id, conversation.name
        
      console.log JSON.stringify data.conversations
      console.info "Fetched #{Object.keys(expose.conversations).length} conversations!"
  
    $.ajax
      url: "#{host}/conversations/?access_token=#{expose.login.access_token}"
      success: on_response

  ###
    @param {string} cid Conversation ID, Example: "496d0d21-0b05-49b5-8087-de94f3465b7b"
    @returns {object}
  ###
  get_conversation: (cid) ->
    
    on_response = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data  
  
    $.ajax
      url: "#{host}/conversations/#{cid}/?access_token=#{expose.login.access_token}"
      success: on_response    

  ###
    @param {string} cid Conversation ID, Example: "496d0d21-0b05-49b5-8087-de94f3465b7b"
    @param {string} plain_message "Hello World!"
    @returns {object}
    @see https://github.com/wearezeta/webrtc/blob/master/ZCore/Messaging/ZBackend.cpp
    @see https://docs.google.com/a/wearezeta.com/document/d/1OufUGikctztsB4ZHBWDAfsQ_f-oCNR89Pcc8sm8un5U
    @see http://en.wikipedia.org/wiki/Universally_unique_identifier#Version_4_.28random.29
    @see https://github.com/LiosK/UUID.js
  ###
  post_message_to_conversation: (cid, plain_message) ->
  
    on_response = (data, textStatus, jqXHR) ->
      console.log JSON.stringify data  
  
    data = {
      nonce: UUID.genV4().hexString
      entities: []
      content: plain_message
    }
  
    $.ajax
      url: "#{host}/conversations/#{cid}/messages/?access_token=#{expose.login.access_token}"
      type: 'POST'
      crossDomain: true
      contentType: 'application/json; charset=utf-8'
      dataType: 'json'
      data: JSON.stringify data
    .done(on_response)
    .fail(on_response)    
#
)()