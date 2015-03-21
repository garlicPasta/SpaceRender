Pixi = require 'pixi.js'
{ Vec2d }= require './Vec2d.coffee'


class Camera
    constructor: (width, height)->
        @xObjects = []
        @yObjects = []
        @center = new Vec2d(0,0) # absolute coordinates
        @last_center = new Vec2d(0,0) # absolute coordinates
        @xPointer= [0,0] #(first element, second element)
        @yPointer= [0,0] #(first Element, second element)

    addGameObjects: (gObjectList)  ->
        # Same Objects but different lists
        @xObjects.push elem for elem in gObjectList
        @yObjects.push elem for elem in gObjectList
        @_sortX()
        @_sortY()

    countGameObjects: ->
        return @xObjects.length

    scroll:(delta) ->
        @center.add(delta)

        if delta.x == 0 
            @_updateYPointer(delta[1])
        else if delta.y == 0 
            @_updateXPointer(delta[0])
        else
            @_updateXPointer(delta[0])
            @_updateYPointer(delta[1])

    _sortX: -> @xObjects.sort((a,b) -> return a.x - b.x)
    _sortY: -> @yObjects.sort((a,b) -> return a.y - b.y)

    _updateYPointer


module.exports = {
    Camera
}
