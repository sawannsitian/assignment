expect = require('chai').expect
sanitizeJson = require('../src/app').sanitizeJson

describe "App", ->
  describe '#sanitizeJson', ->
    
    context 'input is json object', ->
      it 'should return sanitized json for json having only singular keys of parent json key', ->
        input = { attribute_one: "foo",posts: [{ post: { name: "p1", content: "post one" } },{ post: { name: "p2", content: "post two" } },{ post: { name: "p3", content: "post three" } }]}
        expected_output = { attribute_one: "foo",posts: [{ name: "p1", content: "post one" },{ name: "p2", content: "post two" },{ name: "p3", content: "post three" }]}
        result = sanitizeJson(input)
        expect(result).to.deep.equal(expected_output)

      it 'should return sanitized json for json having singular keys of parent json key and other key', ->
        input = { attribute_one: "foo",posts: [{ post: { name: "p1", content: "post one" } },{ post: { name: "p2", content: "post two" } },{ post: { name: "p3", content: "post three" } }, { item: { name: "p3", content: "post three" } }]}
        expected_output = { attribute_one: "foo",posts: [{ name: "p1", content: "post one" },{ name: "p2", content: "post two" },{ name: "p3", content: "post three" }, { item: { name: "p3", content: "post three" } }]}
        result = sanitizeJson(input)
        expect(result).to.deep.equal(expected_output)

      it 'should return sanitized json for json having two level nesting', ->
        input = { contents: [{ content: { name: "p1", contents: [{content: {task:'c1'}},{content: {task:'c2'}}] } },{ content: { name: "p1", contents: [{content: {task:'c1'}},{content: {task:'c2'}}] } }]}
        expected_output = { contents: [{ name: "p1", contents: [{task:'c1'},{task:'c2'}]},{ name: "p1", contents: [{task:'c1'},{task:'c2'}]}]}
        result = sanitizeJson(input)
        expect(result).to.deep.equal(expected_output)

      it 'should return sanitized json for json having three level nesting', ->
        input = { contents: [{ content: { name: "p1", contents: [{content: {tasks:[{task: {name: "t1"}}]}},{content: {task:'c2'}}] } },{ content: { name: "p1", contents: [{content: {task:'c1'}},{content: {task:'c2'}}] } }]}
        expected_output = {"contents":[{"name":"p1","contents":[{"tasks":[{"name":"t1"}]},{"task":"c2"}]},{"name":"p1","contents":[{"task":"c1"},{"task":"c2"}]}]}
        result = sanitizeJson(input)
        expect(result).to.deep.equal(expected_output)

      it 'should return sanitized json for array of json object', ->
        input = [{ attribute_one: "foo",posts: [{ post: { name: "p1", content: "post one" } },{ post: { name: "p2", content: "post two" } },{ post: { name: "p3", content: "post three" } }]},{ attribute_one: "foo",posts: [{ post: { name: "p1", content: "post one" } },{ post: { name: "p2", content: "post two" } },{ post: { name: "p3", content: "post three" } }]}]
        expected_output = [{ attribute_one: "foo",posts: [{ name: "p1", content: "post one" },{ name: "p2", content: "post two" },{ name: "p3", content: "post three" }]},{ attribute_one: "foo",posts: [{ name: "p1", content: "post one" },{ name: "p2", content: "post two" },{ name: "p3", content: "post three" }]}]
        result = sanitizeJson(input)
        expect(result).to.deep.equal(expected_output)

    context 'input is not json object', ->
      it 'should return false for string', ->
        input = "test"
        expected_output = false
        result = sanitizeJson(input)
        expect(result).to.deep.equal(expected_output)

      it 'should return false for number', ->
        input = 1
        expected_output = false
        result = sanitizeJson(input)
        expect(result).to.deep.equal(expected_output)