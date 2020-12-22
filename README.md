# zmgr

manage stackable values such as z-index.

## Usage

    mgr = new zmgr({...})
    ret1 = mgr.add 100, 1
    ret2 = mgr.add 100, 1
    mgr.remove ret1
    mgr.remove ret2


## Constructor options

 - init: default value.
 - step: amount of increase between `add` function calls.


## License

MIT
