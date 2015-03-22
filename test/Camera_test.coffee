chai = require 'chai'
chai.should()
assert = chai.assert

Pixi = require 'pixi.js'
{ Camera } = require '../src/Camera.coffee'
{ GameObject } = require '../src/GameObject.coffee'
{ Vec2d } = require '../src/Vec2d.coffee'


describe 'Camera instance', ->
    camera1 = new Camera(100, 100) 
    it 'start at coordinate origin', ->
        assert (camera1.center.x == 0), 'Camera doesnt spawn on origin'
        assert (camera1.center.y == 0), 'Camera doesnt spawn on origin'
    it 'can manage game Objects', ->
        gameObjects = (new GameObject(x * 13 + 10 ,1) for x in [1..10])
        camera1.addGameObjects gameObjects
        assert (camera1.countGameObjects() == 10), 'Game object cant be added'
    it 'determines if point is in sight', ->
        assert camera1._isVisible('x', 0)
        assert not camera1._isVisible('x', 7)
        assert camera1._isVisible('y', 7)
    it 'pointers inits properly', ->
        camera1._initPointer()
        debugger
        assert camera1.xPointer[0] == 0
        assert camera1.xPointer[1] == 2
        assert camera1.yPointer[0] == 0 
        assert camera1.yPointer[1] == 9
    it 'can scroll', ->
        camera1.scroll(new Vec2d(50, 100))
        debugger
        assert camera1.yPointer[0] == 9 
        assert camera1.yPointer[1] == 9
