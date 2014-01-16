Zeta = {} unless Zeta?
Zeta.Service = {} unless Zeta.Service?
Zeta.Service.URLs = (->
  # Private
  host = 'https://armada-test.z-infra.com'
  urls =
    access: "#{host}/access"
    register: "#{host}/register"
    
  create_access_token_url = (url) ->
    access_token = Zeta.Storage.Session.get_access_token()
    if access_token?
      "#{url}?access_token=#{Zeta.Storage.Session.get_access_token()}"
    else
      console.log "WARNING: Your access token is expired or is not set"
      url
  
  # Public
  change_own_phone_number: -> 
    create_access_token_url "#{host}/self/phone"
    
  get_conversation_by_id: (id) ->
    create_access_token_url "#{host}/conversations/#{id}"

  get_conversations: ->
    create_access_token_url "#{host}/conversations"
    
  get_user_by_id: (id) -> 
    create_access_token_url "#{host}/users/#{id}" 
    
  login: "#{host}/login"    
    
  self: -> 
    create_access_token_url "#{host}/self"
    
  users: ->
    create_access_token_url "#{host}/users"    
#
)()