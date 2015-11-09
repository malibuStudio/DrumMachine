@clearSessions = (arr)->
  i = 0
  while i < arr.length
    Session.set(arr[i])
    i++

@pageSlideDown = (after, func)->
  duration =
    before: constants.duration.page.before
    after: constants.duration.page.after

  before = $('.current-page')
  after = $(after)

  # Page Transition (Before Page)
  TweenMax.to before, duration.before,
    ## opacity: 0
    y: '100%'
    clearProps: 'all'
    onUpdate: ->
      after.addClass('current-page')
    onComplete: ->
      console.log 'Page Transition End (Before)'
      before.removeClass('current-page')
      if func
        func()

@pageFromLeft = (after)->
  duration =
    before: constants.duration.page.before
    after: constants.duration.page.after

  before = $('.current-page')
  after = $(after)

  # after
  after.css(
    'transform': 'translateX(100%)'
    'z-index': '9999999'
  )

  # Page Transition (Before Page)
  TweenMax.to before, duration.before,
    ## opacity: 0
    x: '-30%'
    clearProps: 'all'
    onStart: ->
      before.removeClass('current-page')
    onComplete: ->
      console.log 'Page Transition End (Before)'

  # Page Transition (After Page)
  TweenMax.fromTo after, duration.after,
    x: '100%'
    #opacity: 0
  ,
    x: '0%'
    #opacity: 1
    ease: Power3.easeOut
    clearProps: 'all'
    onComplete: ->
      after.addClass('current-page')
      console.log 'Page Transition End (After)'


@pageFromRight = (after)->
  duration =
    before: constants.duration.page.before
    after: constants.duration.page.after

  before = $('.current-page')
  after = $(after)

  # after
  after.css(
    'transform': 'translateX(100%)'
    'z-index': '9999999'
  )

  # Page Transition (Before Page)
  TweenMax.to before, duration.before,
    ## opacity: 0
    x: '30%'
    clearProps: 'all'
    onStart: ->
      before.removeClass('current-page')
    onComplete: ->
      console.log 'Page Transition End (Before)'


  # Page Transition (After Page)
  TweenMax.fromTo after, duration.after,
    x: '-100%'
    #opacity: 0
  ,
    x: '0%'
    #opacity: 1
    ease: Power3.easeOut
    clearProps: 'all'
    onComplete: ->
      console.log 'Page Transition End (After)'
      after.addClass('current-page')


@pageFromTop = (after)->
  duration =
    before: constants.duration.page.before
    after: constants.duration.page.after

  before = $('.current-page')
  after = $(after)

  after.addClass('current-page')

  # Page Transition (Before Page)
  TweenMax.to before, duration.before,
    ## opacity: 0
    y: '30%'
    clearProps: 'all'
    onStart: ->
      before.removeClass('current-page')
    onComplete: ->
      console.log 'Page Transition End (Before)'


  # Page Transition (After Page)
  TweenMax.fromTo after, duration.after,
    y: '-100%'
    #opacity: 0
  ,
    y: '0%'
    #opacity: 1
    ease: Power3.easeOut
    clearProps: 'all'
    onComplete: ->
      console.log 'Page Transition End (After)'



@pageFromBottom = (after)->
  duration =
    before: constants.duration.page.before
    after: constants.duration.page.after

  before = $('.current-page')
  after = $(after)

  # after
  after.css(
    'transform': 'translateY(100%)'
    'z-index': '9999999'
  )

  # Page Transition (After Page)
  TweenMax.fromTo after, duration.after,
    y: '100%'
  ,
    y: '0%'
    ease: Power3.easeOut
    clearProps: 'all'
    onComplete: ->
      before.removeClass('current-page')
      console.log 'Page Transition End (After)'
      after.addClass('current-page')
