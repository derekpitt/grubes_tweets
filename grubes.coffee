# this will take a twitter timeline from a user and watch it and say whatever they say..
# Also, i'm gonna be drinking a lot of wine during this



# a base class that can run processes
class Process
  constructor: ->
    @util = require 'util'
    @exec = (require 'child_process').exec

  run_process: (command, callback) ->
    process = @exec command, (error, stdout, stderr) ->
      callback stdout if callback?




# say class, just says junk
# voices:
#  Agnes
#  Kathy
#  Princess
#  Vicki
#  Victoria
#
#  Bruce
#  Fred
#  Junior
#  Ralph
#
#  Albert
#  Bad News
#  Bahh
#  Bells
#  Boing
#  Bubbles
#  Cellos
#  Deranged
#  Good News
#  Hysterical
#  Pipe Organ
#  Trinoids
#  Whisper
#  Zarvox

class Say extends Process
  constructor: (@voice = "Alex") ->
    super

  remove_url_from_string: (string) ->
    string.replace /htt(p|ps):\/\/(\w|\.|\/|\?)*/g, ""

  clean_string: (string) ->
    string = @remove_url_from_string string
    string

  say: (string_to_say) ->
    @run_process "say -v \"#{@voice}\" \"#{@clean_string string_to_say}\""



# gets a twitter time line from a user
class TwitterTimeLine extends Process
  constructor: (@user) ->
    super
    @count = 1
    @include_rts = "false"
    @exclude_replies = "true"

    @api_endpoint = "https://api.twitter.com/1/statuses/user_timeline.json?include_rts=#{@include_rts}&screen_name=#{@user}&count=#{@count}&exclude_replies=#{@exclude_replies}"

    console.log @api_endpoint



  parse_json: (json_string) ->
    # ohhh man...
    object = eval json_string

    # this is weird but works..  since everything is an expression, it will
    # return an array for us
    for obj in object
      { text: obj.text, id: obj.id }

  # callback will get called with an array of the tweets
  # just strings...
  get_tweets: (since_id = null, callback) ->
    url_for_api = @api_endpoint
    if since_id?
      url_for_api += "&since_id=#{since_id}"

    @run_process "curl \"#{url_for_api}\"", (json_string) => callback @parse_json json_string



# just watches a timeline and returns new tweets
class TwitterTimeLineWatcher
  constructor: (@user, callback) ->
    @twitter_feed = new TwitterTimeLine @user

    @max_id = null

    do_the_deed = => @get callback
    do do_the_deed

    # check every minute
    setInterval do_the_deed, 1000 * 60
    


  get: (callback) ->
    tweets = @twitter_feed.get_tweets @max_id, (tweets) =>
      for tweet in tweets
        if tweet.id > @max_id
          @max_id = tweet.id
          callback tweet.text




# and let's go!
user = "TechCrunch"

watcher = new TwitterTimeLineWatcher user, (new_tweet) ->
  powpow = new Say
  powpow.say new_tweet

  console.log "NEW TWEET BY #{user}!!!!"
  console.log " -- #{new_tweet}"
  console.log ""
