
@scrollHide = ->
  # Hide Header on on scroll down
  lastScrollTop = 0
  delta = 5
  pageHeader = $('.current-page .p-header')
  navbarHeight = pageHeader.outerHeight()

  $('.p-body').scroll ->
    st = @scrollTop
    # Make sure they scroll more than delta
    if Math.abs(lastScrollTop - st) > delta
      # If they scrolled down and are past the navbar, add class .p-header-up.
      # This is necessary so you never see what is "behind" the navbar.
      if st > lastScrollTop and st > navbarHeight
        # Scroll Down
        pageHeader.removeClass('p-header-down').addClass 'p-header-up'
      else
        # Scroll Up
        if st + $('.p-body-inner').height() > $('#viewport').height()
          pageHeader.removeClass('p-header-up').addClass 'p-header-down'
      lastScrollTop = st