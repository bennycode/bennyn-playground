Zeta = {} unless Zeta?
Zeta.Utils = {} unless Zeta.Utils?
Zeta.Utils.Shorthand = (->  
  animationend: 'animationend oAnimationEnd MSAnimationEnd mozAnimationEnd webkitAnimationEnd'
)()