{ Vec2d } = require './Vec2d.coffee'

class GameObject
    constructor: (@x, @y) ->
        @visibleX = false
        @visibleY = false
    # cameraOrigin is the top left corner of the screen
    setDispCords: (dispOrigin) ->
        @dispCords = new Vec2d(@x - dispOrigin.x, @y - dispOrigin.y)

module.exports = {
    GameObject
}
