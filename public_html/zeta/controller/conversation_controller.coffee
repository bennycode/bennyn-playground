namespace Zeta:Controller:
  class ConversationController
    constructor: () ->
      amplify.subscribe Zeta.Model.EventTypes.Conversation.NEW_MESSAGE, (event) ->
        conversation = Zeta.Storage.Session.get_conversation event.conversation
        Zeta.Instances.ConversationList.highlight_conversation conversation