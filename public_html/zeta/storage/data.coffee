# Abstraction layer for underlying storage system...
# 1. Memory
# 2. Local storage
# 3. Backend call
Zeta = {} unless Zeta?
Zeta.Storage = {} unless Zeta.Storage?
Zeta.Storage.Data = (->
  ###
    Zeta.Storage.Data.async_get_user_by_id("a46ffc68-cb0e-45c1-bff8-13c4db065aa7", true, function(user){console.log(user.name)})
    Zeta.Storage.Data.async_get_user_by_id("ff1c93cf-7795-4b90-9a8e-262e982baa71", false, function(user){console.log(user.name)})
  ###
  async_get_user_by_id: (user_id, force_update, callback) ->
    # First check the memory
    user = Zeta.Storage.Session.get_user user_id
    if user? and not force_update
#      console.log "Found user in browser cache:"
#      console.log "#{JSON.stringify user}"
      callback?(user)
      return user
    else
#      console.log "Requesting user info from backend:"
      Zeta.Service.Main.get_user_by_id user_id, callback
      return user_id
#
)()