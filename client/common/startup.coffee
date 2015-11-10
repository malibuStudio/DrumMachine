Meteor.startup ->
  m.mount document.body, mcom.Main
  mcom.didLoaded()