benny = new Zeta.Registration.User('Benny', 'benny@wearezeta.com', 'abc123')
# alert benny.name.value
# alert benny.name.isValid()
# alert benny.hasValidRegistrationData()
# alert benny.getRegistrationPayload()
# alert benny.name.guidance.title

Zeta.Registration.Registration.init()
Zeta.Registration.Registration.register(benny)