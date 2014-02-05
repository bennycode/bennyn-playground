###
Polyfill for Array.prototype.map()
@see https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map
###
unless Array::map
  Array::map = (f) ->
    result = []
    i = 0

    while i < @length
      result[i] = f(this[i], i)
      ++i
    result

###
Read string chars as hex chars
###
String::b16decode = ->
  @match(/../g).map((x) ->
    String.fromCharCode parseInt(x, 16)
  ).join ""