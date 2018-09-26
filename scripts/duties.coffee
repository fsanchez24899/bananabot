# Description:
#   Hubot duties reminder system
#
# Commands:
#   hubot duties - gets your upcoming duties
#   hubot duties XXX - gets XXX's upcoming duties
#   hubot duties upcoming - gets the upcoming houseworks
#   hubot duties link - return master spreadsheet link
#
# Configuration:
#   HUBOT_HOUSEWORKS_SPREADSHEET - spreadsheet ID of master H-man
#   HUBOT_HOUSEWORKS_REMINDER - reminder schedule 
#
# Author:
#   Detry322

module.exports = (robot) ->
  robot.respond /slackdoc$/i, (res) ->
      res.send "https://docs.google.com/document/d/1kpa4Gye5De8-Q9IFWE6Jtn-OGMbBZaakFLh_6LyZiNM/edit"
