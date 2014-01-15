Zeta = {} unless Zeta?
Zeta.Storage = {} unless Zeta.Storage?
Zeta.Storage.Session = (->
  # Private
  user = null
  login = null
  conversations = {}
  
  # Plain setters
  set_user: (value) ->
    user = value
    
  set_login: (value) ->
    login = value
    
  set_conversations: (value) ->
    conversations = value    
  
  # Plain getters
  get_access_token: ->
    login.access_token
  
  get_user: ->
    user
    
  get_login: ->
    login
    
  get_conversations: ->
    conversations
    
  get_number_of_conversations: ->
    Object.keys(conversations).length
    
  # Extra methods
  set_conversation_creator: (key, creator) ->
    conversations[key].creator = creator
  
  add_conversation: (key, value) ->
    conversations[key] = value  
    
  list_conversations: ->
    for key, value of conversations
      value.log_name()
   
#
)()