Zeta = {} unless Zeta?
Zeta.Storage = {} unless Zeta.Storage?
Zeta.Storage.Session = (->
  # Private
  user = null
  login = null
  conversations = {}
  users = {}
  
  # Plain setters
  current_conversation_id: ""
  
  set_user: (value) ->
    user = value
    
  set_login: (value) ->
    login = value
    
  set_conversation: (cid, conversation) ->
    conversations[cid] = conversation
    
  set_conversations: (value) ->
    conversations = value    
  
  # Plain getters
  get_access_token: ->
    if not login or not login.access_token
      console.log "WARNING: Your access token is expired or is not set"
    else
      login.access_token
  
  get_user: ->
    user
    
  get_users: ->
    users    
    
  get_login: ->
    login
    
  get_conversation: (cid) ->
    conversations[cid]
    
  get_conversations: ->
    conversations
    
  get_number_of_conversations: ->
    Object.keys(conversations).length
    
  # Extra methods
  add_user: (user) ->
    users[user.id] = user
  
  set_conversation_creator: (key, creator) ->
    conversations[key].creator = creator
  
  add_conversation: (key, value) ->
    conversations[key] = value  
    
  list_conversations: ->
    for key, value of conversations
      value.log_name()
   
#
)()