sanitizeJson = require('../src/app').sanitizeJson
input = { attribute_one: "foo",posts: [{ post: { name: "p1", content: "post one" } },{ post: { name: "p2", content: "post two" } },{ post: { name: "p3", content: "post three" } }]}
output = sanitizeJson(input)
console.log(output)