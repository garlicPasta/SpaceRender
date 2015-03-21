Pixi = require 'pixi.js'


class Vec2d extends Pixi.Point
    
    add: (point) ->
        @x+= point.x
        @y+= point.y

module.exports = {
   Vec2d 
}
