# Description:
#   Cron commands.
#
# Dependencies:
#   cron
#
# Commands:
#   None
#
# Notes:
#   Scheduled tasks

cron = require('cron').CronJob

monitor_urls = [
  'http://nekobato.net'
  'http://dav.nekobato.net'
  'http://endnanonna.nekobato.net'
]

module.exports = (robot) ->

  # cron for ***.nekobato.net
  #
  new cron '* 0 * * * *', () ->

    for url in monitor_urls
      robot.http(url).get() (err, res, body) ->
        if res?.statusCode? is not 200
          robot.send "#{url} との通信が取れないにゃ..."

  , null, true, "Asia/Tokyo"
