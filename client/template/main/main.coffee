@mcom=
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
    controller: ->

    view: ->
      [
        m "[id='viewport']", [
          m ".sidebar", [
            m ".sidebar-top", [
              m "a[href='#']", mcom.onSideBarCloseHandler, [
                m "span", [
                  m "i.icon.close" ,"Close"
                ]
              ]
            ]
            m "ul.sample-list", [
              m "li.draggable.sample-item[data-drum='/kick2.wav']", [
                m "a[href='#']", "Amazing Kick"
                m ".type", "Kick"
              ]
              m "li.draggable.sample-item[data-drum='/kick3.wav']", [
                m "a[href='#']", "Booooom"
                m ".type", "Kick"
              ]
              m "li.draggable.sample-item[data-drum='/snare2.wav']", [
                m "a[href='#']", "Massive Snare"
                m ".type", "Snare"
              ]
              m "li.draggable.sample-item[data-drum='/effect1.wav']", [
                m "a[href='#']", "Lazer"
                m ".type", "Effect"
              ]
            ]
          ]
          m ".navbar", [
            m "a[data-action='sidebar'][data-feedback='true'][href='#']", mcom.onSideBarHandler, [
              m ".inner", m "i.ion-navicon"
            ]
          ]
          m "[id='content']", [
            m ".content-body", [
              m "[id='Drummer']", [
                m "h1", ["Scribbly Pad",m "small", "by Malibu Studio"]
                m ".pads", [
                  m ".row", [
                    m.component mcom.padComponent,
                      wav:'/kick1.wav'
                      key: '81'
                    m.component mcom.padComponent,
                      wav:'/snare1.wav'
                      key: '87'
                    m.component mcom.padComponent,
                      wav:'/hh1.wav'
                      key: '69'
                  ]
                  m ".row", [
                    m.component mcom.padComponent,
                      wav:'/clap1.wav'
                      key: '65'
                    m.component mcom.padComponent,
                      wav:'/crash1.wav'
                      key: '83'
                    m.component mcom.padComponent,
                      wav:'/hh2.wav'
                      key: '68'
                  ]
                  m ".row", [
                    m.component mcom.padComponent,
                      wav:'/hh1.wav'
                      key: '90'
                    m.component mcom.padComponent,
                      wav:'/hh1.wav'
                      key: '88'
                    m.component mcom.padComponent,
                      wav:'/hh1.wav'
                      key: '67'
                  ]
                ]
                m "ul.knobs", [
                  m "li.knob.back", m "span.knob.front"
                  m "li.knob.back", m "span.knob.front"
                  m "li.knob.back", m "span.knob.front"
                  m "li.knob.back", m "span.knob.front"
                ]
              ]
            ]
          ]
        ]
      ]


#Template.body.onRendered ->
#  Draggable.create '.knob.front',
#      type: 'rotation'
#      throwProps: true
#
#  $(document).on 'keydown', (e)->
#    key = e.which or e.keyCode
#
#    pad = $('[data-key='+key+']')
#
#    padDown(e, pad)
#
#  $(document).on 'keyup', (e)->
#    key = e.which or e.keyCode
#
#    pad = $('[data-key='+key+']')
#
#    padUp(e, pad)
#
#  $(document).on 'mouseup touchend', (e)->
#    pad = $('.pad-front')
#    if pad.hasClass('hit')
#      TweenMax.to pad, 0.05,
#      clearProps: 'all'
#      onStart: ->
#        pad.removeClass('hit')
#
#  dragMoveListener = (event)->
#    target = event.target
#    # keep the dragged position in the data-x/data-y attributes
#    x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx
#    y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy
#
#    # translate the element
#    target.style.transform = target.style.webkitTransform = 'translate(' + x + 'px, ' + y + 'px)'
#    target.style.zIndex = 10000
#
#    # update the posiion attributes
#    target.setAttribute('data-x', x)
#    target.setAttribute('data-y', y)
#
#  revertDraggable = (el)->
#    el.style.transform = el.style.webkitTransform = 'none'
#    el.style.zIndex = 1
#    el.setAttribute('data-x', 0)
#    el.setAttribute('data-y', 0)
#
#  # target elements with the "drag-element" class
#  interact('.draggable').draggable
#    # enable inertial throwing
#    inertia: true
#    # call this function on every dragmove event
#    onmove: dragMoveListener
#    onend: (event)->
#      if not $(event.target).hasClass('drag-element--dropped') and not $(event.target).hasClass('drag-element--dropped-text')
#        revertDraggable(event.target)
#
#
#
#  # enable draggables to be dropped into this
#  interact('.pad-front').dropzone
#    # only accept elements matching this CSS selector
#    accept: '.draggable'
#    # Require a 75% element overlap for a drop to be possible
#    overlap: 0.5
#    ondragenter: (event)->
#      $(event.target).addClass('highlight')
#    ondragleave: (event)->
#      $(event.target).removeClass('highlight')
#    ondrop: (event)->
#      $(event.target).removeClass('highlight')
#      $(event.target).attr('data-drum', $(event.relatedTarget).attr('data-drum'))
#
#    ondropdeactivate: (event)->
#      console.log 'drag deactivate'
#      # remove active dropzone feedback
#      # classie.remove(event.target, 'paint-area--highlight');