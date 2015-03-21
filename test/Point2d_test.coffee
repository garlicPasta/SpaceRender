chai = require 'chai'
chai.should()
assert = chai.assert

{ Vec2d } = require '../src/Vec2d.coffee'

describe 'Point2d instance', ->
    vec = new Vec2d(10,13) 
    it 'supports addtion', ->
        vec.add(new Vec2d(5, 5))
        assert (vec.x == 15), 'vec.x wrong computed'
        assert (vec.y == 18), 'vec.y wrong computed'
