namespace Zeta:Model:
  class Conversation
    constructor: (data) ->
      @name = data.name
      @id = data.id
      @type = data.type
      @last_event_time = data.last_event_time
      @last_event = data.last_event
      @creator = data.creator # UUID of the creator
      @members = data.members
    log_name: =>
      console.log "#{@id}: #{@name}"