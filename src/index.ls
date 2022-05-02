zmgr = (opt={}) ->
  @opt = opt
  @stack = []
  @step = opt.step or 1
  if opt.init? => @init = opt.init
  @_g = {} <<< zmgr.layer <<< (opt.layer or {})
  @_v = {}
  @_s = {}
  @

zmgr.prototype = Object.create(Object.prototype) <<< do
  scope: (n, s) ->
    add: (_n,_s) ~> @add (if _n? => _n else n), (if _s? => _s else s)
    remove: (_n, _v) ~> @remove (if _n? => _n else n), _v
  add: (v, s = 0) ->
    if !(v?) or typeof(v) == \number =>
      if !(v?) => v = @init
      if @init? => v = if @step > 0 => Math.max(@init,v) else Math.min(@init,v)
      if !(@value?) => @value = v
      v = if @step > 0 => Math.max(@value,v) else Math.min(@value,v)
      v = v + (if @step > 0 => 1 else -1) * Math.max(Math.abs(@step),Math.abs(s))
      @stack.push v
      @value = v
      return v
    else
      n = v
      v = (if @step > 0 => Math.max else Math.min)(@_g[n], @_v[n] or @_g[n])
      v = v + (if @step > 0 => 1 else -1) * Math.max(Math.abs(@step), Math.abs(s))
      @_s[][n].push v
      @_v[n] = v
      return v



  remove: (n, v) ->
    if typeof(n) == \number =>
      if !~(i = @stack.indexOf n) => return
      @stack.splice i, 1
      @value = @stack[* - 1]
    else
      if !(i = @_s[][n].indexOf v) => return
      @_s[][n].splice i, 1
      @_v[n] = @_s[* - 1]

zmgr.layer = do
  notify: 5000
  splash: 4000
  modal: 3000
  fixed: 2000
  float: 1000
  base: 1

zmgr.notify = \notify
zmgr.splash = \splash
zmgr.modal = \modal
zmgr.fixed = \fixed
zmgr.float = \float
zmgr.base = \base

if module? => module.exports = zmgr
else if window? => window.zmgr = zmgr
