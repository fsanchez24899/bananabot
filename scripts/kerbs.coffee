# Description:
#   Gets the user ID of students in 2.009 Slack Team
#
# Commands:
#   hubot initials add <display name> <user ID> - Adds person to kerberos database.
#   hubot initials get <display name> - Returns the person data for the user ID.
#   hubot initials get <user ID> - Returns the person data for the given display name.
#
# Author:
#   Detry322, fsanchez24899


# note that real name => initals

sendUser = (robot, res, user) ->
  res.send "*#{user['initials']}*: #{user['real_name']}, Slack: #{robot.pingStringForUser(user)}, Email: #{user['email_address']}"

module.exports = (robot) ->

  robot.brain.userForInitials = (initials) ->
    for own key, user of robot.brain.data.users
      if user['initials'] == initials
        return user
    return null

  robot.respond /initials add @?([a-z0-9_\-]+) @?([a-z0-9_\-]+)$/, (res) ->
    initials = res.match[1]
    slack_name = res.match[2]
    name = slack_name
    user = robot.brain.userForName(slack_name)
    if user?
      user['initials'] = initials
      sendUser(robot, res, user)
      name = user['real_name']
    initials_table = robot.brain.get('team-kerberos') or {}
    initials_table[initials] = {
      initials: initials,
      name: name
    }
    robot.brain.set('team-kerberos', initials_table)
    res.send "Added *#{initials}*: #{name}"

  robot.respond /initials get @?([a-z0-9_\-]+)$/, (res) ->
    initials = res.match[1]
    user = robot.brain.userForInitials(initials)
    if user?
      sendUser(robot, res, user)
    else
      # This means they were never matched with a slack user => not yet added?
      initials_table = robot.brain.get('team-kerberos') or {}
      if initials_table[initials]?
        person = initials_table[initials]
        res.send "*#{person['initials']}*: #{person['name']}"
      else
        res.send "No one with real name #{initials} exists."

  robot.respond /initials get @?([a-z0-9_\-]+)$/, (res) ->
    slack_name = res.match[1]
    user = robot.brain.userForName(slack_name)
    if user? and user['initials']
      sendUser(robot, res, user)
    else
      res.send "No one with user ID #{slack_name} exists."