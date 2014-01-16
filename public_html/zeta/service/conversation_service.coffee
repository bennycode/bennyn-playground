###
  Conversation API:
  https://docs.z-infra.com/dev-device-api/latest/concepts/conversations.html
  
  API tester:
  https://api-docs.z-infra.com/swagger/  
###
Zeta = {} unless Zeta?
Zeta.Service = {} unless Zeta.Service?
Zeta.Service.ConversationService = (->

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