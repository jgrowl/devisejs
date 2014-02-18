assert = require 'assert'
devise = require '../../build/devise.min'

admin =
  email: "admin@example.com"
  roles_mask: 1

user =
    email: "user@example.com"
    roles_mask: 2

userAndModerator =
  email: "userandmoderator@example.com"
  roles_mask: 6

roles = [
  'admin'
  'user'
  'moderator'
  'author'
]

describe 'devise', ->
  it 'can determine a user is not a non existent role', ->
    currentUser = new devise.User
    currentUser.loadRoles(roles)
    currentUser.loadUserData(user)
    expect(currentUser.isRole('non-existent-role')).toBe(false)

  # User
  it 'can determine a user does not have a role they do not belong to', ->
    currentUser = new devise.User
    currentUser.loadRoles(roles)
    currentUser.loadUserData(user)
    expect(currentUser.isRole('admin')).toBe(false)

  it 'can determine a user has a role', ->
    currentUser = new devise.User
    currentUser.loadRoles(roles)
    currentUser.loadUserData(user)
    expect(currentUser.isRole('user')).toBe(true)

  # User and Moderator
  it 'can determine a user/moderator does not have an admin role', ->
    currentUser = new devise.User
    currentUser.loadRoles(roles)
    currentUser.loadUserData(userAndModerator)
    expect(currentUser.isRole('admin')).toBe(false)

  it 'can determine a user/moderator has a user role', ->
    currentUser = new devise.User
    currentUser.loadRoles(roles)
    currentUser.loadUserData(userAndModerator)
    expect(currentUser.isRole('user')).toBe(true)

  it 'can determine a user/moderator has a moderator role', ->
    currentUser = new devise.User
    currentUser.loadRoles(roles)
    currentUser.loadUserData(userAndModerator)
    expect(currentUser.isRole('moderator')).toBe(true)

  # Admin
  it 'can determine an admin really is an admin', ->
    currentUser = new devise.User
    currentUser.loadRoles(roles)
    currentUser.loadUserData(admin)
    expect(currentUser.isRole('admin')).toBe(true)

  # Logged in
  it 'can determine if a user is logged in', ->
    currentUser = new devise.User

    expect(currentUser.isLoggedIn()).toBe(false)

    currentUser.loadRoles(roles)
    currentUser.loadUserData(admin)
    expect(currentUser.isLoggedIn()).toBe(true)
