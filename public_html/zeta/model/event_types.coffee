Zeta = {} unless Zeta?
Zeta.Model = {} unless Zeta.Model?
Zeta.Model.EventTypes = 
  View:
    OPEN_CONVERSATION: "USER-CLICKED-ON-CONVERSATION"
  Conversation:
    HOT_KNOCK: "conversation.hot-knock"  
    KNOCK: "conversation.knock"
    IMAGE: "conversation.asset-add"
    NEW_MESSAGE: "conversation.message-add"