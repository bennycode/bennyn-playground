################################################################################
# General
# - https://github.com/wearezeta/zclient-ios-mac/blob/master/Shared/Registration/Assets/Registration.strings
################################################################################
namespace Zeta:Registration:
  class UserProperty
    constructor: (@value = '') ->
      @guidance = {
        level: 'error'
        title: 'guide.title'
        explanation: 'guide.explanation'
      }

    is_valid: ->
      @value.length > 0
      
################################################################################
# Username
################################################################################
namespace Zeta:Registration:
  class Username extends UserProperty
    constructor: (value) ->
      super(value)
      @validate()
      
    validate: =>
      console.log "Username length: #{@value.length}"
    
      if @value.length == 0
        @guidance.title = "Please fill in your name first"
        @guidance.explanation = ""
        @valid = false
        
      else if @value.length == 1
        @guidance.title = "2 characters or more"
        @guidance.explanation = ""
        @valid = false
        
      else if @value.length > 1
        @guidance.title = ""
        @guidance.explanation = ""
        @valid = true
      
    is_valid: =>
      @valid

################################################################################
# Password
################################################################################
namespace Zeta:Registration:
  class UserPassword extends UserProperty
    constructor: (value) ->
      super(value)
      
    is_valid: =>
      @value.length > 5
 
################################################################################
# Email
# - profile.email.guidance.empty.title
# - profile.email.guidance.empty.explanation
################################################################################
namespace Zeta:Registration:
  class UserEmailAddress extends UserProperty
    constructor: (value) ->
      super(value)  
  
    emailPattern = /// ^ #begin of line
       ([\w.-]+)         #one or more letters, numbers, _ . or -
       @                 #followed by an @ sign
       ([\w.-]+)         #then one or more letters, numbers, _ . or -
       \.                #followed by a period
       ([a-zA-Z.]{2,6})  #followed by 2 to 6 letters or periods
      $ ///i #end of line and ignore case
      
    is_valid: ->
      if @value.match emailPattern
        true
      else
        false