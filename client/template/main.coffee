@padDown = (e, padKey)->
  pad = $(e.target)
  pad = padKey if padKey?

  sndName = pad.attr('data-drum')
  snd = new Audio(sndName)
  snd.play()
  snd.currentTime = 0

  TweenMax.to pad, 0.025,
    left: -2
    top: -2
    onStart: ->
      pad.addClass('hit')

@padUp = (e, padKey)->
  pad = $(e.target)
  pad = padKey if padKey?

  TweenMax.to pad, 0.05,
    clearProps: 'all'
    onStart: ->
      pad.removeClass('hit')

Template.body.events
  'click [data-action=sidebar]': (e)->
    e.preventDefault()

    openSidebar = ()->
      sidebar = document.querySelector('.sidebar')

      TweenMax.to sidebar, 0.25,
        x: 0
        ease: Power4.easeIn
        # onStart: ->
        #   overlay = '<div class="sidebar-overlay"></div>'
        #   sidebar.insertAdjacentHTML('afterend', overlay)

        #   added = document.querySelector('.sidebar-overlay')
        #   added.style.position = 'fixed'
        #   added.style.top = '0'
        #   added.style.left = '0'
        #   added.style.width = '100vw'
        #   added.style.height = '100vh'
        #   added.style.zIndex = '40'
        #   added.style.opacity = '0'
        #   added.style.background = 'transparent'

    openSidebar()

    return false
  'click .sidebar-overlay, click .sidebar-top a': (e)->
    sidebar = document.querySelector('.sidebar')

    TweenMax.to sidebar, 0.2,
      x: '-100%'
      clearProps: 'all'
      onStart: ->
        added = document.querySelector('.sidebar-overlay')
        # added.parentNode.removeChild(added)

    return false

  'mousedown .pad-front, touchstart .pad-front': (e)->
    e.preventDefault()

    padDown(e)

  'mouseup .pad-front, touchend .pad-front': (e)->
    e.preventDefault()

    padUp(e)




Template.body.onRendered ->
  Draggable.create '.knob.front',
      type: 'rotation'
      throwProps: true

  $(document).on 'keydown', (e)->
    key = e.which or e.keyCode

    pad = $('[data-key='+key+']')

    padDown(e, pad)

  $(document).on 'keyup', (e)->
    key = e.which or e.keyCode

    pad = $('[data-key='+key+']')

    padUp(e, pad)

  $(document).on 'mouseup touchend', (e)->
    pad = $('.pad-front')
    if pad.hasClass('hit')
      TweenMax.to pad, 0.05,
      clearProps: 'all'
      onStart: ->
        pad.removeClass('hit')

  dragMoveListener = (event)->
    target = event.target
    # keep the dragged position in the data-x/data-y attributes
    x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx
    y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy

    # translate the element
    target.style.transform = target.style.webkitTransform = 'translate(' + x + 'px, ' + y + 'px)'
    target.style.zIndex = 10000

    # update the posiion attributes
    target.setAttribute('data-x', x)
    target.setAttribute('data-y', y)

  revertDraggable = (el)->
    el.style.transform = el.style.webkitTransform = 'none'
    el.style.zIndex = 1
    el.setAttribute('data-x', 0)
    el.setAttribute('data-y', 0)

  # target elements with the "drag-element" class
  interact('.draggable').draggable
    # enable inertial throwing
    inertia: true
    # call this function on every dragmove event
    onmove: dragMoveListener
    onend: (event)->
      if not $(event.target).hasClass('drag-element--dropped') and not $(event.target).hasClass('drag-element--dropped-text')
        revertDraggable(event.target)



  # enable draggables to be dropped into this
  interact('.pad-front').dropzone
    # only accept elements matching this CSS selector
    accept: '.draggable'
    # Require a 75% element overlap for a drop to be possible
    overlap: 0.5
    ondragenter: (event)->
      $(event.target).addClass('highlight')
    ondragleave: (event)->
      $(event.target).removeClass('highlight')
    ondrop: (event)->
      $(event.target).removeClass('highlight')
      $(event.target).attr('data-drum', $(event.relatedTarget).attr('data-drum'))

    ondropdeactivate: (event)->
      console.log 'drag deactivate'
      # remove active dropzone feedback
      # classie.remove(event.target, 'paint-area--highlight');