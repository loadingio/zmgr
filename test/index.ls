require! <[./main]>

s = new main step: -1
console.log s.push(123,10)
console.log s.push(123,20)
console.log s.push(123)
console.log s.push(123)
s.pop 126
console.log s.stack
console.log s.push(123)
