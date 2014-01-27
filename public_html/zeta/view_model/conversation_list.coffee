namespace Zeta:ViewModel:
  class ConversationList
    constructor: () ->
      console.log "Zeta:ViewModel:ConversationList"
    
    highlight_conversation: (conversation) ->
      $("##{conversation.dom_selector}").addClass("animated bounce").one('webkitAnimationEnd mozAnimationEnd oAnimationEnd animationEnd', ->
        $(this).removeClass "animated bounce")