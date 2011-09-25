Grubes loves him some rangers!!
===============================

It's friday night! you know what that means! I got a couple of bottles of wine and started to do some coding.

As most of my crazy experiments go, Grubes from the ticket caught my eye on twitter. That guy is one live tweeting son of a B!

Why watch the rangers when I can run a process that will just tell me what is going on in ranger world live (via grubes and in a whisper voice), without being logged into twitter or watch the game on TV!

---

Example Code:
-------------

    user = "tweetgrubes"

    watcher = new TwitterTimeLineWatcher user, (new_tweet) ->
      powpow = new Say
      powpow.say new_tweet

      console.log "NEW TWEET BY #{user}!!!!"
      console.log " -- #{new_tweet}"
      console.log ""

---

It doesn't speak RT's, or @replies.

It also checks every minute for now (you are limited to 150 API calls/hr to twitter)

---

I also recorded a video of me coding this in real time. You will see me start from a blank file and go through documentation to get it going.\

Tons of laughs and will make you cry!

---

Plenty of refactoring to be done!

Written in CoffeeScript

Run in node
