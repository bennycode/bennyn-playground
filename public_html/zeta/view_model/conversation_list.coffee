namespace Zeta:ViewModel:
  class ConversationList
    constructor: () ->
      console.log "Zeta:ViewModel:ConversationList"
    
    highlight_conversation: (conversation) ->
      # Make noise
      if conversation.id isnt Zeta.Storage.Session.current_conversation_id
        $("##{conversation.dom_selector}").addClass("animated bounce").one('webkitAnimationEnd mozAnimationEnd oAnimationEnd animationEnd', ->
          $(this).removeClass "animated bounce")
      
      # Add message to view model
      # TODO: Until now this is done in the MainViewModel which is deprecated