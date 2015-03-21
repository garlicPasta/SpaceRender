Pixi = require 'pixi.js'
{ Vec2d }= require './Vec2d.coffee'


class Camera
    constructor: (width, length)->
        @xObjects = []
        @yObjects = []
        @center = new Vec2d(0,0) # absolute coordinates
        @last_center = new Vec2d(0,0) # absolute coordinates
        @radius = Math.ceil(Max.max(width, length))
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
        @center = @last_center
        @center.add(delta)

        if delta.x != 0 
            forward = @center.x > @last_center.x
            @xPointer = _updatePointer forward, @xPointer, @xObjects, 'x'
        else if delta.y != 0 
            forward = @center.y > @last_center.y
            @yPointer = _updatePointer forward, @yPointer, @yObjects, 'x'

    _sortX: -> @xObjects.sort((a,b) -> return a.x - b.x)
    _sortY: -> @yObjects.sort((a,b) -> return a.y - b.y)

    _updatePointer:(forward, pointer, list, dim) ->
        left = pointer[0]
        right = pointer[1]
        if forward
            left++ until @_isVisible dim list[left] and left < list.length
            right++ until @_isVisible dim list[left] and right < list.length
            right++ until @_isVisible dim list[left] and right < list.length
        else
            left-- until @_isVisible dim list[left] and left < list.length
            right-- until @_isVisible dim list[left] and right < list.length
            right-- until @_isVisible dim list[left] and right < list.length
        return [left, right]

    _isVisible: (dim, p) ->
        if dim == 'x'
                return @center.x - @radius <= p <= @center.x + radius
        return @center.y - @radius <= p <= @center.y + radius


module.exports = {
    Camera
}
