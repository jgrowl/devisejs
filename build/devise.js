(function() {
  (function(root, factory) {
    if (typeof exports === "object" && exports) {
      module.exports = factory();
    } else if (typeof define === "function" && define.amd) {
      define(factory);
    } else {
      root.devisejs = factory();
    }
  })(this, (function() {
    var User, exports;
    exports = {};
    exports.name = "devisejs";
    exports.version = "0.1.0";
    User = (function() {
      function User() {
        this.rawRoles = [];
        this.userData = {};
        this.roles = {};
        this._isLoggedIn = false;
      }

      User.prototype.buildRoles = function(roles) {
        var bitMask, intCode, role, userRoles;
        bitMask = "01";
        userRoles = {};
        for (role in roles) {
          intCode = parseInt(bitMask, 2);
          userRoles[roles[role]] = {
            bitMask: intCode,
            title: roles[role]
          };
          bitMask = (intCode << 1).toString(2);
        }
        return userRoles;
      };

      User.prototype.isRole = function(role) {
        var r;
        if (this.roles === void 0) {
          return false;
        }
        r = this.roles[role];
        if (r === void 0) {
          return false;
        }
        return (r.bitMask & this.rolesMask) === r.bitMask;
      };

      User.prototype.isLoggedIn = function() {
        return this._isLoggedIn;
      };

      User.prototype.loadUserData = function(userData) {
        var k, v;
        for (k in userData) {
          v = userData[k];
          this[k] = v;
        }
        return this._isLoggedIn = true;
      };

      User.prototype.loadRoles = function(rawRoles) {
        this.rawRoles = rawRoles;
        return this.roles = this.buildRoles(this.rawRoles);
      };

      return User;

    })();
    exports.User = User;
    return exports;
  }));

}).call(this);
