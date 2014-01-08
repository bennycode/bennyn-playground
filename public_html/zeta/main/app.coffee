pw = new UserPassword("abc123")

benny = new User('Benny', 'benny@wearezeta.com', 'abc123')
# alert benny.name.value
# alert benny.name.isValid()
# alert benny.hasValidRegistrationData()
# alert benny.getRegistrationPayload()
# alert benny.name.guidance.title

# Registration.register(benny)
Registration.init()