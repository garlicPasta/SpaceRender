chai = require 'chai'
chai.should()
assert = chai.assert

Pixi = require 'pixi.js'
{ Camera } = require '../src/Camera.coffee'
{ GameObject } = require '../src/GameObject.coffee'


describe 'Camera instance', ->
    camera1 = new Camera(100, 100) 
    it 'start at coordinate origin', ->
        assert (camera1.center.x == 0), 'Camera doesnt spawn on origin'
        assert (camera1.center.y == 0), 'Camera doesnt spawn on origin'
    it 'can manage game Objects', ->
        gameObjects = (new GameObject(x * 33 + 10 ,1) for x in [1..10])
        camera1.addGameObjects gameObjects
        assert (camera1.countGameObjects() == 10), 'Game object cant be added'
    it 'can scroll', ->
        assert (camera1.countGameObjects() > 0), 'Game object cant be added'
    it 'determines if point is in sight', ->
        assert camera1._isVisible('x', 0)
        assert not camera1._isVisible('x', 4)
        assert camera1._isVisible('y', 7)
    it 'pointers inits properly', ->

