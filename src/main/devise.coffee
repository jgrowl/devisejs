((root, factory) ->
  if typeof exports is "object" and exports
    module.exports = factory() # CommonJS
  else if typeof define is "function" and define.amd
    define factory # AMD (RequireJS and family)
  else
    root.devisejs = factory() # Browser <script>
  return
) this, (->
  exports = {}
  exports.name = "devisejs"
  exports.version = "0.1.0"

  class User
    constructor: ()->
      @rawRoles = []
      @userData = {}
      @roles = {}
      @_isLoggedIn = false

    buildRoles: (roles) ->
      bitMask = "01"
      userRoles = {}
      for role of roles
        intCode = parseInt(bitMask, 2)
        userRoles[roles[role]] =
          bitMask: intCode
          title: roles[role]
        bitMask = (intCode << 1).toString(2)
      userRoles

    isRole: (role) ->
      return false if (@roles == undefined)
      r = @roles[role]
      return false if (r == undefined)
      (r.bitMask& @rolesMask) == r.bitMask

    isLoggedIn: ->
      @_isLoggedIn

    loadUserData: (userData) ->
      @email = userData.email
      @rolesMask = userData.roles_mask
      @_isLoggedIn = true

    loadRoles: (@rawRoles) ->
      @roles = @buildRoles(@rawRoles)

  exports.User = User

  exports
)
