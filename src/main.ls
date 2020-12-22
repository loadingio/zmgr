main = (opt={}) ->
  @opt = opt
  @stack = []
  @step = opt.step or 1
  @

main.prototype = Object.create(Object.prototype) <<< do
  add: (v,s=0) ->
    if !(@value?) => @value = v
    v = if @step > 0 => Math.max(@value,v) else Math.min(@value,v)
    v = v + (if @step > 0 => 1 else -1) * Math.max(Math.abs(@step),Math.abs(s))
    @stack.push v
    @value = v
    return v

  remove: (v) ->
    if !~(i = @stack.indexOf v) => return
    @stack.splice i, 1

if window? => window.stack = main
if module? => module.exports = main
