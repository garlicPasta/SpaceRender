chai = require 'chai'
chai.should()

Pixi = require 'pixi.js'
{Camera} = require '../src/Camera.coffee'


describe 'RenderService', ->
    camera1 = new Camera(100, 100) 
    it 'start at coordinate origin', ->
        chai.assert camera1.center, new Pixi.Point(0,0)
