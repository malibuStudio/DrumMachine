@LOADER =
  show: ->
    dimmer = document.createElement('div')
    dimmer.classList.add 'dimmer'

    loader = document.createElement('div')
    loader.classList.add 'loading'
    dimmer.appendChild loader

    body = document.querySelector('body')

    body.insertBefore(dimmer, body.firstChild)

    TweenMax.to '.dimmer', 0.3,
      opacity: 1
      onComplete: ->
        console.log 'Loading'

  destroy: ->
    dimmer = document.querySelector('.dimmer')

    TweenMax.to '.dimmer', 0.3,
      opacity: 0
      onComplete: ->
        console.log 'Done'
        dimmer.parentNode.removeChild(dimmer)

