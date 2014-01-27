namespace Zeta:Controller:
  class ConversationController
    constructor: () ->
      amplify.subscribe Zeta.Model.EventTypes.Conversation.NEW_MESSAGE, (event) ->
        conversation = Zeta.Storage.Session.get_conversation event.conversation
        console.log conversation.get_dom_selector()