zmgr = require '../dist/index'

s = new zmgr step: -1
console.log s.add(123,10)
console.log s.add(123,20)
console.log s.add(123)
console.log s.add(123)
s.remove 126
console.log s.add(123)
console.log s.add(zmgr.notify)
b = s.add(zmgr.notify)
console.log s.add(zmgr.notify)
s.remove(b)
console.log s.add(zmgr.notify)
console.log s.add(zmgr.fixed)
console.log s.add(zmgr.notify)
console.log s.add(zmgr.fixed)
