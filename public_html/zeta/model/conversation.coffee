namespace Zeta:Model:
  class Conversation
    constructor: (data) ->
      $.extend @, data
      @has_participants = (if (@members.others.length > 0) then true else false) 
      
    log_name: =>
      console.log "#{@id}: #{@name}"
      
    get_number_of_other_participants: =>
      @members.others.length ?= 0