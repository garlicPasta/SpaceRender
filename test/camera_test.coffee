chai = require 'chai'
chai.should()
Pixi = require 'pixi.js'

{Camera} = require '../src/Camera.coffee'


describe 'Camera instance', ->
    camera1 = new Camera(100, 100) 
    it 'start at coordinate origin', ->
        chai.assert new Pixi.Point(0,0), new Pixi.Point(0,0)
