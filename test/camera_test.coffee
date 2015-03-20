chai = require 'chai'
chai.should()
Pixi = require 'pixi.js'

{Camera} = require '../src/Camera.coffee'


describe 'Camera instance', ->
    camera1 = new Camera(100, 100) 
    it 'start at coordinate origin', ->
        camer1.center.should new Pixi.Point(0,0)
