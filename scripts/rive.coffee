# Description:
#   ラブライブタイトルジェネレータ
#
# Commands:
#   rive [WORD]
#
# Author:
#   nekobato

fs = require('fs')
path = require('path')
cp = require('child_process')
request = require('request')
process = require('process')
imagemagick = require('imagemagick')

module.exports = (robot) ->

  # robot.hear /badger/i, (msg) ->
  #   msg.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"
  #

  robot.respond /rive (.+)/i, (msg) ->
    if /[^ァ-ヶ！]|[ヰヱ]/.test msg.match[1]
      msg.send "全部カタカナじゃないと無理にゃ"
      return

    strings = msg.match[1].split('').map (v) -> path.resolve "rivefont/#{v}.png"
    imagemagick.convert strings.concat(['-background', 'white', '+append', 'tmp/out.png']), (err, stdout) ->

      robot.emit 'telegram:invoke', 'sendPhoto', {
        chat_id: msg.message.room
        photo: fs.createReadStream(path.resolve 'tmp/out.png')
      }, (err, res) ->
        console.log err, res

  #
  # robot.hear /I like pie/i, (msg) ->
  #   msg.emote "makes a freshly baked pie"
  #
  # lulz = ['lol', 'rofl', 'lmao']
  #
  # robot.respond /lulz/i, (msg) ->
  #   msg.send msg.random lulz
  #
  # robot.topic (msg) ->
  #   msg.send "#{msg.message.text}? That's a Paddlin'"
  #
  #
  # enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
  # leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
  #
  # robot.enter (msg) ->
  #   msg.send msg.random enterReplies
  # robot.leave (msg) ->
  #   msg.send msg.random leaveReplies
  #
  # answer = process.env.HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING
  #
  # robot.respond /what is the answer to the ultimate question of life/, (msg) ->
  #   unless answer?
  #     msg.send "Missing HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING in environment: please set and try again"
  #     return
  #   msg.send "#{answer}, but what is the question?"
  #
  # robot.respond /you are a little slow/, (msg) ->
  #   setTimeout () ->
  #     msg.send "Who you calling 'slow'?"
  #   , 60 * 1000
  #
  # annoyIntervalId = null
  #
  # robot.respond /annoy me/, (msg) ->
  #   if annoyIntervalId
  #     msg.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #     return
  #
  #   msg.send "Hey, want to hear the most annoying sound in the world?"
  #   annoyIntervalId = setInterval () ->
  #     msg.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #   , 1000
  #
  # robot.respond /unannoy me/, (msg) ->
  #   if annoyIntervalId
  #     msg.send "GUYS, GUYS, GUYS!"
  #     clearInterval(annoyIntervalId)
  #     annoyIntervalId = null
  #   else
  #     msg.send "Not annoying you right now, am I?"
  #
  #
  # robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
  #   room   = req.params.room
  #   data   = JSON.parse req.body.payload
  #   secret = data.secret
  #
  #   robot.messageRoom room, "I have a secret: #{secret}"
  #
  #   res.send 'OK'
  #
  # robot.error (err, msg) ->
  #   robot.logger.error "DOES NOT COMPUTE"
  #
  #   if msg?
  #     msg.reply "DOES NOT COMPUTE"
  #
  # robot.respond /have a soda/i, (msg) ->
  #   # Get number of sodas had (coerced to a number).
  #   sodasHad = robot.brain.get('totalSodas') * 1 or 0
  #
  #   if sodasHad > 4
  #     msg.reply "I'm too fizzy.."
  #
  #   else
  #     msg.reply 'Sure!'
  #
  #     robot.brain.set 'totalSodas', sodasHad+1
  #
  # robot.respond /sleep it off/i, (msg) ->
  #   robot.brain.set 'totalSodas', 0
  #   robot.respond 'zzzzz'
