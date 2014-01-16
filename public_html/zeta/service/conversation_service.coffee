###
  Conversation API:
  https://docs.z-infra.com/dev-device-api/latest/concepts/conversations.html
  
  API tester:
  https://api-docs.z-infra.com/swagger/  
###
Zeta = {} unless Zeta?
Zeta.Service = {} unless Zeta.Service?
Zeta.Service.ConversationService = (->

  create_self_conversation: (callback) ->
    config = 
      url: Zeta.Service.URLs.create_access_token_url "/conversations/self"
      type: 'POST'
      on_done:
        callback  

    Zeta.Utils.RequestHandler.send_request config  

  get_last_events: (callback) ->
    config = 
      url: Zeta.Service.URLs.create_access_token_url "/conversations/last-events"
      type: 'GET'
      on_done:
        callback  

    Zeta.Utils.RequestHandler.send_request config  

  remove_user_from_conversation: (values, callback) ->
    config = 
      url: Zeta.Service.URLs.create_access_token_url "/conversations/#{values.cid}/members/#{values.uid}"
      type: 'DELETE'
      on_done:
        callback  
  
    Zeta.Utils.RequestHandler.send_request config

  add_users_to_conversation: (values, callback) ->
    config = 
      url: Zeta.Service.URLs.create_access_token_url "/conversations/#{values.id}/members"
      type: 'POST'
      data: values.data
      on_done:
        callback  
  
    Zeta.Utils.RequestHandler.send_json config   

  update_conversation_properties: (values, callback) ->
    config = 
      url: Zeta.Service.URLs.create_access_token_url "/conversations/#{values.id}"
      type: 'PUT'
      data: values.data
      on_done:
        callback  
  
    Zeta.Utils.RequestHandler.send_json config 
    
  create_one_to_one_conversation: (values, callback) ->
    config = 
      url: Zeta.Service.URLs.create_access_token_url "/conversations/one2one"
      type: 'POST'
      data: values.data
      on_done:
        callback  
  
    Zeta.Utils.RequestHandler.send_json config    

  create_conversation: (values, callback) ->
    config = 
      url: Zeta.Service.URLs.create_access_token_url "/conversations"
      type: 'POST'
      data: values.data
      on_done:
        callback  
  
    Zeta.Utils.RequestHandler.send_json config    

  get_conversation_by_id: (data, callback) ->
    config = 
      url: Zeta.Service.URLs.create_access_token_url "/conversations/#{data.id}"
      type: 'GET'
      on_done:
        callback  

    Zeta.Utils.RequestHandler.send_request config

  get_conversations: (callback) ->
    config = 
      url: Zeta.Service.URLs.create_access_token_url "/conversations"
      type: 'GET'
      on_done:
        callback  

    Zeta.Utils.RequestHandler.send_request config
    
  get_conversation_messages: (values, callback) ->
    values.data = {} unless values.data
    values.data.access_token = Zeta.Storage.Session.get_access_token()
  
    config = 
      url: Zeta.Service.URLs.create_url "/conversations/#{values.id}/messages"
      data: values.data
      type: 'GET'
      on_done:
        callback    
        
    Zeta.Utils.RequestHandler.send_request config

  post_message_to_conversation: (data, callback) ->
    config = 
      url: Zeta.Service.URLs.create_access_token_url "/conversations/#{data.id}/messages"
      type: 'POST'
      data:
        content: data.plain_message
        entities: []
        nonce: Zeta.Utils.Misc.create_random_uuid()
      on_done:
        callback  
  
    Zeta.Utils.RequestHandler.send_json config
#
)()