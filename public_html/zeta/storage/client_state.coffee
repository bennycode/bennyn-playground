# TODO 1: All data here should be proper mapped objects! (check constructor.name)
# TODO 2: All data here should be stored with http://amplifyjs.com/
Zeta = {} unless Zeta?
Zeta.Storage = {} unless Zeta.Storage?
Zeta.Storage.ClientState = (->
  # Private
  @current_conversation_id = ""
  # Public
  set_current_conversation_id: (value) =>
    @current_conversation_id = value
  get_current_conversation_id: =>
    @current_conversation_id
  get_current_conversation: =>
    Zeta.Storage.Session.get_conversation @current_conversation_id
#
)()