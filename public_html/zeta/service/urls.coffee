Zeta = {} unless Zeta?
Zeta.Service = {} unless Zeta.Service?
Zeta.Service.URLs = (->

  # Private
  property =
    host: 'armada-test.z-infra.com'
  
  # Public
  get_host: ->
    property.host
  
  create_url: (path) ->
    "https://#{property.host}#{path}"   
  
  create_access_token_url: (path) ->
    url = @create_url path
    
    if Zeta.Storage.Session.get_access_token()?
      url += "?access_token=#{Zeta.Storage.Session.get_access_token()}"
      
    url
#
)()