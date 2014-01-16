###
  Conversation API:
  https://docs.z-infra.com/dev-device-api/latest/concepts/conversations.html
  
  API tester:
  https://api-docs.z-infra.com/swagger/  
###
Zeta = {} unless Zeta?
Zeta.Service = {} unless Zeta.Service?
Zeta.Service.ConversationService = (->

  ###
    @param {object} data Data is an object that contains:
    {string} id Conversation ID, Example: "496d0d21-0b05-49b5-8087-de94f3465b7b"
    @param {function} callback
  ###
  get_conversation_by_id: (data, callback) ->
    config = 
      url: Zeta.Service.URLs.get_conversation_by_id(data.id)
      type: 'GET'
      on_done:
        callback  

    Zeta.Utils.RequestHandler.send_request config

  ###
    @param {function} callback
  ###
  get_conversations: (callback) ->
    config = 
      url: Zeta.Service.URLs.get_conversations()
      type: 'GET'
      on_done:
        callback  

    Zeta.Utils.RequestHandler.send_request config

#
)()