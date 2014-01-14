Zeta = {} unless Zeta?
Zeta.Storage = {} unless Zeta.Storage?
Zeta.Storage.Session = (->
  # Private
  user = null
  login = null
  conversations = null
  
  # Setters
  set_user: (value) ->
    user = value
    
  set_login: (value) ->
    login = value
    
  set_conversations: (value) ->
    conversations = value    
  
  # Getters
  get_access_token: ->
    login.access_token
  
  get_user: ->
    user
    
  get_login: ->
    login
    
  get_conversations: ->
    conversations
#
)()