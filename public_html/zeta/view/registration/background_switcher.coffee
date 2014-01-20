namespace Zeta:View:Registration:
  class BackgroundSwitcher
    constructor: (config) ->
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
      @selector_wrapper = config.selector_wrapper
      @selector_animated = config.selector_animated
      @selector_not_animated = config.selector_not_animated
      
    test: =>
      alert @selector_wrapper