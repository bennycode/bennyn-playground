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