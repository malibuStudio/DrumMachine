$(document).delegate '[data-feedback=true]', 'mousedown touchstart', (e)->
  target = $(e.target)
  FEEDBACK(target)

@FEEDBACK = (target, func)->
  target.addClass('feedback')
  target.one malibu.instance.animationEnd, ->
    target.removeClass('feedback')
    if func?
      console.log 'End run func'
      func()
