namespace Zeta:View:Registration:
  class BackgroundSwitcher
    constructor: (config) ->
      # Images
      @images = config.images
      @images_buffer = []
      # Elements
      @wrapper = $(config.selector_wrapper)
      @animated = $(config.selector_animated, @wrapper)
      @not_animated = $(config.selector_not_animated, @wrapper)
      # Methods
      @get_background_image = ->
        if @images.length is 0 and @images_buffer.length > 0
          @images.push.apply @images, @images_buffer
          @images_buffer = []
          @get_background_image()
        else
          image = @images.shift()
          @images_buffer.push image
          image
      @change_background_image = (element) ->
        image_path = @get_background_image()
        element.css 'background-image', "url('#{image_path}')"
      @start_scaling = (element) ->
        element.addClass 'scale'
      @start_fade_out = (element, not_animated) ->
        element.addClass('fade-out').one Zeta.Utils.Shorthand.animationend, (event) =>
          not_animated.css 'z-index', '2'
          element.css 'z-index', '1'
          element.removeClass 'scale'
          element.removeClass 'fade-out'
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