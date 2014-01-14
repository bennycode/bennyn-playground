Zeta = {} unless Zeta?
Zeta.App = {} unless Zeta.App?
Zeta.App.Session = (->
  # Private
  user = null
  login = null
  conversations = null
  
  # Public
  set_user: (value) ->
    user = value
    
  set_login: (value) ->
    login = value
    
  set_conversations: (value) ->
    conversations = value    
  
  get_user: ->
    user
    
  get_login: ->
    login
    
  get_conversations: ->
    conversations
#
)()