class Dashing.Hotness1 extends Dashing.Widget

  #@accessor 'value', Dashing.AnimatedValue

  constructor: ->
    super

  onData: (data) ->
    debugger
    node = $(@node)
    value = parseFloat data.value
    cool = parseFloat node.data "cool"
    warm = parseFloat node.data "warm"
    level = switch
      when value <= cool then 0
      when value >= warm then 4
      else 
        bucketSize = (warm - cool) / 3 # Total # of colours in middle
        Math.ceil (value - cool) / bucketSize
  
    backgroundClass = "hotness#{level}"
    lastClass = @get "lastClass"
    node.toggleClass "#{lastClass} #{backgroundClass}"
    @set "lastClass", backgroundClass
