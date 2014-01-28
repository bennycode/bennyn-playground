Zeta = {} unless Zeta?
Zeta.Controller = {} unless Zeta.Controller?
Zeta.Controller.ConversationController = (->
  # Private
  on_new_message = (event) ->
    conversation = Zeta.Storage.Session.get_conversation event.conversation
    Zeta.Instances.ConversationList.highlight_conversation conversation
    # TODO: MainViewModel should become ConversationController
    Zeta.Instances.MainViewModel.show_new_message conversation, event
  # Public
  init: ->
    amplify.subscribe Zeta.Model.EventTypes.Conversation.NEW_MESSAGE, on_new_message
#
)().init()