Zeta = {} unless Zeta?
Zeta.Model = {} unless Zeta.Model?
Zeta.Model.EventTypes = 
  Conversation:
    HOT_KNOCK: "conversation.hot-knock"  
    KNOCK: "conversation.knock"
    IMAGE: "conversation.asset-add"
    NEW_MESSAGE: "conversation.message-add"