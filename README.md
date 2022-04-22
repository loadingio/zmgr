# zmgr

manage stackable values such as z-index.


## Install

    npm install --save zmgr


## Usage

include `dist/index.js` then:

    mgr = new zmgr({...})
    ret1 = mgr.add 100, 1
    ret2 = mgr.add 100, 1
    mgr.remove ret1
    mgr.remove ret2


## Constructor options

 - `init`: default value. optional.
   - if provided, the first added value will be updated based on `init` and `step`:
     - if step > 0: max(init, added) will be used
     - if step < 0: min(init, added) will be used
 - `step`: amount of increase between `add` function calls. default 1 if omitted.
   - can be negative, indicating a decreased value.
 - `layer`: object containing customized value for named layers. in this object:
   - key as layer name.
   - value as layer value. 


## API

 - `add(v,s)`: use a certain  `v`. Return assigned value to use.
   - params:
     - `v`: expected z-index or string to indicate layer to use. see `Named Layers` section below.
       - when `v` is a number, value is added to default layer.
     - `s`: custom step. direction is ignored.
       - use `step` (in constructor option) if omitted.
 - `remove(n, v)`: remove a used value from layer n.
   - when n is a number, value is removed from default layer.
 - `scope(n)`: return a scoped interface to this object with `add` and `remove` methods.
   - `add` / `remove` work the same as `add` / `remove` in this object, except they can be called without parameters.
   - `n`: default layer name for this scope.


## Layered Values

You can use multiple `zmgr` with different `init` value to better separate values for different purpose. For example, assume we have some dialogs to popup. Some of them are just hints and some of them are important message and users must interact with them.

We can thus use 2 `zmgr` for configuring them `z-index` accordingly:

    manager = do
      prompt: new zmgr init: 10000
      hint: new zmgr init: 100

    ldcv = do
      prompt1: new ldcover zmgr: manager.prompt
      prompt2: new ldcover zmgr: manager.prompt
      hint1: new ldcover zmgr: manager.hint
      hint2: new ldcover zmgr: manager.hint


### Named Layers

Alternatively, you can use `string` as layer name when adding a value:

    mgr = new zmgr({
      group: {
        "my new group": 100  # initial value for `my new group` layer is 100
        "default": 10        # initial value for `default` layer is 10
      }
    );
    mgr.add "my new group" # return 101
    mgr.add "default" # return 11
    mgr.add "my new group" # return 102

To scope APIs to specific layer by default, use `scope`:

    splash = mgr.scope('splash')
    val = splash.add()  # return 4001


zmgr is by default shipped with following layers (and their corresponding default values):

 - `notify`: 5000
 - `splash`: 4000
 - `modal`: 3000
 - `fixed`: 2000
 - `float`: 1000
 - `base`: 1

instead of using these names as string directly, you can use predefined members such as `zmgr.notify`:

    mgr.add(zmgr.notify);



## Fallback

While zmgr is necessary for aligning values such as `z-index` across components, we can prepare a fallback one if zmgr is not available ( example in livescript ):

    zmgr = do
      add: (v) -> @[]s.push(z = Math.max(v or 0, (@s[* - 1] or 0) + 1)); return z
      remove: (v) -> if (i = @[]s.indexOf(v)) < 0 => return else @s.splice(i,1)


## License

MIT
