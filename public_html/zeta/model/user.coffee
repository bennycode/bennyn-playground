###
  Docs:
  https://docs.z-infra.com/dev-device-api/latest/reference/users.html
###
namespace Zeta:Model:
  class User
    constructor: (data) ->
      $.extend @, data