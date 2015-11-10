@mcom=
  # collections
  padMap: [
    [
      { wav: '/kick1.wav', key: 81 }
      { wav: '/snare1.wav', key: 87 }
      { wav: '/hh1.wav', key: 69 }
    ]
    [
      { wav: '/clap1.wav', key: 65 }
      { wav: '/crash1.wav', key: 83 }
      { wav: '/hh2.wav', key: 68 }
    ]
    [
      { wav: '/hh1.wav', key: 90 }
      { wav: '/hh1.wav', key: 88 }
      { wav: '/hh1.wav', key: 67 }
    ]
  ]
  draggableSamples: [
    { wav: '/kick2.wav', name: 'Amazing Kick', type: 'Kick' }
    { wav: '/kick3.wav', name: 'Booooom', type: 'Kick' }
    { wav: '/snare2.wav', name: 'Massive Snare', type: 'Snare' }
    { wav: '/effect1.wav', name: 'Lazer', type: 'Effect' }
  ]
  knobs: [
    { name: 'cut', value: 1 }
    { name: 'Q', value: 1}
    { name: 'vol', value: 1 }
    { name: 'pan', value: 0 }
  ]
  # it is fired when the initial HTML document has been completely loaded and parsed.
  didLoaded: ->
    Draggable.create '.knob.front',
      type: 'rotation'
      throwProps: true

    $(document).on 'keydown', (e)->
      key = e.which or e.keyCode

      pad = $('[data-key='+key+']')

      mcom.padDown(e, pad)

    $(document).on 'keyup', (e)->
      key = e.which or e.keyCode

      pad = $('[data-key='+key+']')

      mcom.padUp(e, pad)

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

  padDown: (e, padKey)->
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
  padUp: (e, padKey)->
    pad = $(e.target)
    pad = padKey if padKey?

    TweenMax.to pad, 0.05,
      clearProps: 'all'
      onStart: ->
        pad.removeClass('hit')
  # components
  padComponent:
    controller: (data)->
      wav: data.wav
      key: data.key
    view: (data)->
      m ".pad", [
        m ".pad-front.q[data-drum='#{data.wav}'][data-key='#{data.key}']", mcom.onPadHandler, [
          m ".activate"
        ]
      ]
  onPadHandler:
    onmousedown: (e)->
      mcom.padDown e
    onmouseup: (e)->
      mcom.padUp e
    ontouchstart: (e)->
      mcom.padDown e
    ontouchend: (e)->
      mcom.padUp e
  draggableSampleComponent:
    controller: (data)->
      wav: data.wav
      name: data.name
      type: data.type
    view: (data)->
      m "li.draggable.sample-item[data-drum='#{data.wav}']",
        m "a[href='#']", "#{data.name}"
        m ".type", "#{data.type}"
  knobComponent:
    controller: (data)->
      data
    view: (data)->
      m "li.knob.back",
        m "span.knob.front", data.name

# event handlers
  onSideBarHandler:
    onclick: (e)->
      e.preventDefault()

      openSidebar = ()->
        sidebar = document.querySelector('.sidebar')

        TweenMax.to sidebar, 0.25,
          x: 0
          ease: Power4.easeIn
      openSidebar()
      false
  onSideBarCloseHandler:
    onclick: (e)->
      e.preventDefault()
      console.log 'on click'
      sidebar = document.querySelector('.sidebar')

      TweenMax.to sidebar, 0.2,
        x: '-100%'
        clearProps: 'all'
        onStart: ->
          added = document.querySelector('.sidebar-overlay')
          # added.parentNode.removeChild(added)

      false
  Main:
    view: ->
      m "#viewport",
        m ".sidebar",
          m ".sidebar-top",
            m "a[href='#']", mcom.onSideBarCloseHandler,
              m "span",
                m "i.icon.close" ,"Close"
          m "ul.sample-list",
            m.component mcom.draggableSampleComponent, obj for obj in mcom.draggableSamples
        m ".navbar",
          m "a[data-action='sidebar'][data-feedback='true'][href='#']", mcom.onSideBarHandler,
            m ".inner", m "i.ion-navicon"
        m "#content",
          m ".content-body",
            m "#Drummer",
              m "h1",
                "Scribbly Pad",
                m "small", "by Malibu Studio"
              m ".pads",
                m ".row", (m.component mcom.padComponent, obj for obj in objs) for objs in mcom.padMap
              m "ul.knobs",
                m.component mcom.knobComponent, obj for obj in mcom.knobs
