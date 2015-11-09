Meteor.startup ->
  # set Locale
  moment.locale _.last navigator.languages

  # initialize geolocation coords
  Geolocation.currentLocation()