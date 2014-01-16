Zeta = {} unless Zeta?
Zeta.Service = {} unless Zeta.Service?
Zeta.Service.URLs = (->

  # Private
  property =
    host: 'https://armada-test.z-infra.com'
  
  # Public
  create_url: (path) ->
    "#{property.host}#{path}"   
  
  create_access_token_url: (path) ->
    url = @create_url path
    
    if Zeta.Storage.Session.get_access_token()?
      url += "?access_token=#{Zeta.Storage.Session.get_access_token()}"
      
    url
#
)()