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
      @has_participants = (if (@members.others.length > 0) then true else false) 
      
    log_name: =>
      console.log "#{@id}: #{@name}"
      
    get_number_of_other_participants: =>
      @members.others.length ?= 0