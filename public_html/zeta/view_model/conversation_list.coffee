Zeta = {} unless Zeta?
Zeta.ViewModel = {} unless Zeta.ViewModel?
Zeta.ViewModel.ConversationList = (->
  # Private
  @conversation_messages = ko.observableArray []
  # Public
  show_new_message: (conversation, event) =>
    if conversation.id is Zeta.Storage.Session.current_conversation_id
      user = Zeta.Storage.Data.async_get_user_by_id event.from
      if user.name?
        @conversation_messages.push "#{user.name}: #{event.data.content}"
      else
        @conversation_messages.push "#{event.from}: #{event.data.content}"
  highlight_conversation: (conversation) ->
    if typeof conversation isnt 'object'
      console.log "Conversation ID is not available"
      return
    # Make noise
    if conversation.id isnt Zeta.Storage.Session.current_conversation_id
      $("##{conversation.dom_selector}").addClass("animated bounce").one "webkitAnimationEnd mozAnimationEnd oAnimationEnd animationEnd", ->
        $(this).removeClass "animated bounce"
#
)()