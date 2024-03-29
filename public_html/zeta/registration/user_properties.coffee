################################################################################
# General
# - https://github.com/wearezeta/zclient-ios-mac/blob/master/Shared/Registration/Assets/Registration.strings
################################################################################
namespace Zeta:Registration:
  class UserProperty
    constructor: (@value = '') ->
      @valid = false
      @guidance = {
        is_critical: false
        title: 'guide.title'
        explanation: 'guide.explanation'
      }
    set_guidance: (is_critical, title, explanation) ->
      @guidance.is_critical = is_critical
      @guidance.title = title
      @guidance.explanation = explanation
      if @guidance.is_critical is true
        @valid = false
      
################################################################################
# Username
# "profile.username.placeholder"# = "Username";
# "profile.username.hint" = "Enter username";
# "profile.username.guidance.invalidcharacters" = "Just letters and numbers, please";
# "profile.username.guidance.tooshort" = "Your username must be 3 characters or more";
################################################################################
namespace Zeta:Registration:
  class Username extends UserProperty
    constructor: (value) ->
      super(value)
      @validate()
      
    validate: =>
      console.log "Username length: #{@value.length}"
    
      if @value.length is 0
        @valid = false
        @guidance.is_critical = true
        @guidance.title = "Please fill in your name first"
        @guidance.explanation = ""
        
      else if @value.length is 1
        @valid = false
        @guidance.is_critical = true
        @guidance.title = "2 characters or more"
        @guidance.explanation = ""
        
      else if @value.length > 1
        @valid = true
        @guidance.is_critical = false
        @guidance.title = ""
        @guidance.explanation = ""

################################################################################
# Password
# "profile.password.placeholder"# = "Password";
# "profile.password.hint" = "Enter password";
# "profile.password.guidance.tooshort.title" = "Please provide a valid password";
# "profile.password.guidance.tooshort.explanation" = "6 characters or more";
# "profile.password.guidance.spacenotallowed" = "Please delete any spaces and try again";
# "profile.password.verify.hint" = "Re-enter password";
################################################################################
namespace Zeta:Registration:
  class UserPassword extends UserProperty
    constructor: (value) ->
      super(value)
      @validate()
      
    validate: =>
      console.log "Password length: #{@value.length}"  
      
      if @value.length is 0
        @valid = false     
        @guidance.title = "Enter password"
        @guidance.explanation = ""
        
      else if @value.length < 6
        @valid = false    
        @guidance.title = "Please provide a valid password"
        @guidance.explanation = "6 characters or more"
        
      else 
        @valid = true    
        @guidance.title = ""
        @guidance.explanation = ""
 
################################################################################
# Email
# "profile.email.guidance.empty.title"# = "An email address is required";
# "profile.email.guidance.empty.explanation" = "Allows access to your account in case you forget your password. ";
# "profile.email.guidance.noemailnophone.title" = "A phone number is recommended";
# "profile.email.guidance.noemailnophone.explanation" = "Your phone number enables us to connect you with people you know.";
# "profile.email.placeholder" = "Email";
# "profile.email.hint" = "Enter email";
# "profile.email.guidance.invalidcharacters.title" = "Only letters and numbers, please";
# "profile.email.guidance.invalidcharacters.explanation" = "";
# "profile.email.guidance.missingat.title" = "Don't forget the @";
# "profile.email.guidance.missingat.explanation" = "";
# "profile.email.guidance.tooshort.title" = "2 characters or more";
# "profile.email.guidance.tooshort.explanation" = "";
# "profile.email.guidance.domainnamewithoutdot.title" = "Dot required in domain name";
# "profile.email.guidance.domainnamewithoutdot.explanation" = "";
# "profile.email.guidance.tldtooshort.title" = "2 characters or more";
# "profile.email.guidance.tldtooshort.explanation" = "";
# "profile.email.guidance.enterverification.title" = "Look for an email in your inbox and follow the link in it to verify your address.";
# "profile.email.guidance.enterverification.explanation" = "";
# "profile.email.guidance.alreadyinuse.title" = "Email address already taken";
# "profile.email.guidance.alreadyinuse.explanation" = "";
# "profile.email.guidance.alreadyentered-inactive.title" = "Email is already associated with another account, but has not been verified. Re-send verification email";
# "profile.email.guidance.alreadyentered-inactive.title.link1" = "Re-send";
# "profile.email.guidance.alreadyentered-inactive.explanation" = "";
################################################################################
namespace Zeta:Registration:
  class UserEmailAddress extends UserProperty
    constructor: (value) ->
      super(value)  
      @validate()
      
    validate: =>
      console.log "Email length: #{@value.length}"
    
      if @value.length == 0
        @valid = false
        @guidance.is_critical = false
        @guidance.title = "Enter email"
        @guidance.explanation = ""
        
      else if @value.length == 1
        @valid = false
        @guidance.is_critical = false
        @guidance.title = "2 characters or more"
        @guidance.explanation = ""
        
      # Enough chars available
      else if @value.length > 1
        
        # Is there an @?
        if @value.indexOf("@") == -1
          @valid = false
          @guidance.is_critical = true
          @guidance.title = "Don't forget the @"
          @guidance.explanation = ""

        # Do we have a dot (.) ?
        else if @value.indexOf(".") == -1
          @valid = false
          @guidance.is_critical = true
          @guidance.title = "Dot required in domain name"
          @guidance.explanation = ""

        # Yes, everything is right in place :)
        else
          @valid = true
          @guidance.is_critical = false
          @guidance.title = ""
          @guidance.explanation = ""