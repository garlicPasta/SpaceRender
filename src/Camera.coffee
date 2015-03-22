Pixi = require 'pixi.js'
{ Vec2d }= require './Vec2d.coffee'


class Camera
    constructor: (width, length)->
        @xObjects = []
        @yObjects = []
        @center = new Vec2d(0,0) # absolute coordinates
        @last_center = new Vec2d(0,0) # absolute coordinates
        @radius = Math.ceil(Math.max(width, length) / 2)
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

    setDisplayCords:(obj) ->
        displayOrigin = [@center.x - @radius, @center.y - @radius]
        for i in [@xPointer[0].. @xPointer[1]]
            do (i) ->
                @xObjects[i].setDispCords displayOrigin

    scroll:(delta) ->
        @last_center = @center.clone()
        @center.add(delta)

        if delta.x != 0 
            forward = @center.x > @last_center.x
            @xPointer = @_updatePointer forward, @xPointer, 'x', @xObjects.length 
        if delta.y != 0 
            forward = @center.y > @last_center.y
            @yPointer = @_updatePointer forward, @yPointer, 'y', @yObjects.length

    _sortX: -> @xObjects.sort((a,b) -> return a.x - b.x)
    _sortY: -> @yObjects.sort((a,b) -> return a.y - b.y)

    _initPointer: ->
        @xPointer = @_updatePointer(true, @xPointer, 'x', @xObjects.length)
        @yPointer = @_updatePointer(true, @yPointer, 'y', @yObjects.length)

    _updatePointer:(forward, pointer, dim, listLength) ->
        left = pointer[0]
        right = pointer[1]
        if forward
            right++ while right+1 < listLength and not @_isVisible(dim,right+1) and not @_cameraOverJump(dim,forward, right+1)
            right++ while right+1 < listLength and @_isVisible(dim,right+1) and not @_cameraOverJump(dim,forward, right+1)
            debugger
            left++ until left == right or @_isVisible(dim,left)
        else
            left-- while 0 <= left-1 and not @_isVisible(dim,left-1) and not @_cameraOverJump(dim,forward, left-1)
            left-- while 0 <= left-1  and @_isVisible(dim,left-1) and not @_cameraOverJump(dim,forwardm, left-1)
            right-- until right == left or @_isVisible(dim,right)
        return [left, right]

    _isVisible: (dim, i) ->
        if dim == 'x'
                return @center.x - @radius <= @xObjects[i].x <= @center.x + @radius
        return @center.y - @radius <= @xObjects[i].y <= @center.y + @radius

    _cameraOverJump: (dim, forward, i) ->
        if dim == 'x'
            if forward
                return @center.x + @radius < @xObjects[i].x
            return @center.x - @radius > @xObjects[i].x
        else
            if forward
                return @center.y + @radius < @xObjects[i].y
            return @center.y - @radius > @xObjects[i].y


module.exports = {
    Camera
}
