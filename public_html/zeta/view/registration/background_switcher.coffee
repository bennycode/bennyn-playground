namespace Zeta:View:Registration:
  class BackgroundSwitcher
    constructor: (config) ->
      # Images
      @array_1 = [
        'images/welcome_screen_photos/test_bg_01.jpg',
        'images/welcome_screen_photos/test_bg_02.jpg',
        'images/welcome_screen_photos/test_bg_03.jpg',
        'images/welcome_screen_photos/test_bg_04.jpg',
        'images/welcome_screen_photos/test_bg_05.jpg',
        'images/welcome_screen_photos/test_bg_06.jpg',
        'images/welcome_screen_photos/test_bg_07.jpg',
        'images/welcome_screen_photos/test_bg_08.jpg',
        'images/welcome_screen_photos/test_bg_09.jpg',
        'images/welcome_screen_photos/test_bg_10.jpg'
      ]
      @array_2 = []
      # Selectors
      @selector_wrapper = config.selector_wrapper
      @selector_animated = config.selector_animated # front
      @selector_not_animated = config.selector_not_animated # back
      # Elements
      @wrapper = $(config.selector_wrapper)
      @animated = $(config.selector_animated, @wrapper)
      @not_animated = $(config.selector_not_animated, @wrapper)
      # Methods
      @get_background_image = ->
        if @array_1.length is 0 and @array_2.length > 0
          @array_1.push.apply @array_1, @array_2
          @array_2 = []
          @get_background_image()
        else
          image = @array_1.shift()
          @array_2.push image
          image
      @change_background_image = (element) ->
        image_path = @get_background_image()
        element.css 'background-image', "url('#{image_path}')"
      @start_scaling = (element) ->
        element.addClass 'scale'
      @start_fade_out = (element, not_animated) ->
        element.addClass("fade-out").one "webkitAnimationEnd", (event) =>
          not_animated.css "z-index", "2"
          element.css "z-index", "1"
          element.removeClass "scale"
          element.removeClass "fade-out"
          # Switch objects and start again
          @start_animation not_animated, element
      # Initialization
      @init()

    init: =>
      height = @wrapper.css 'height'
      @animated.css 'top', "-#{height}"
      @change_background_image @animated
      @start_animation @animated, @not_animated
      
    start_animation: (animated, not_animated) =>
      @change_background_image not_animated
      @start_scaling animated
      @start_fade_out animated, not_animated      