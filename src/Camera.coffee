Pixi = require 'pixi.js'
{ Vec2d }= require './Vec2d.coffee'


class Camera
    constructor: (width, length)->
        @xObjects = []
        @yObjects = []
        @center = new Vec2d(0,0) # absolute coordinates
        @last_center = new Vec2d(0,0) # absolute coordinates
        @radius = Math.ceil(Math.max(width, length) / 2)
        @xPointer= [-1,0] #(first element, second element)
        @yPointer= [-1,0] #(first Element, second element)

    addGameObjects: (gObjectList)  ->
        # Same Objects but different lists
        @xObjects.push elem for elem in gObjectList
        @yObjects.push elem for elem in gObjectList
        @_sortX()
        @_sortY()

    getVisibleGameObjects: ->
        deltaXPointer = @xPointer[1]-@xPointer[0] 
        deltaYPointer = @yPointer[1]-@yPointer[0] 
        if  deltaXPointer < deltaYPointer
            if deltaXPointer == 1 
                return []
            visibleObjects = @xObjects[@xPointer[0]+1..@xPointer[1]-1].filter((obj)-> obj.visibleY)
        else
            if deltaYPointer == 1 
                return []
            visibleObjects = @yObjects[@yPointer[0]+1..@yPointer[1]-1].filter((obj)-> obj.visibleX)

        dispOrigin = [@center.x - @radius, @center.y - @radius]
        obj.setDispCords(dispOrigin) for obj in visibleObjects
        return visibleObjects

    countGameObjects: ->
        return @xObjects.length

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
            right++ while right < listLength and not @_isVisible(dim,right) and not @_cameraOverJump(dim,forward, right)
            right++ while right < listLength and @_isVisible(dim,right) and not @_cameraOverJump(dim,forward, right)
            left++ while left+1 < right and not @_isVisible(dim,left+1)
        else
            left-- while 0 <= left and not @_isVisible(dim,left) and not @_cameraOverJump(dim,forward, left)
            left-- while 0 <= left  and @_isVisible(dim,left) and not @_cameraOverJump(dim,forwardm, left)
            right-- while right-1 > left and not @_isVisible(dim,right-1)
        return [left, right]

    _isVisible: (dim, i) ->
        if dim == 'x'
            if @center.x - @radius <= @xObjects[i].x <= @center.x + @radius
                @xObjects[i].visibleX = true
                return true
            @xObjects[i].visibleX = false
            return false

        if @center.y - @radius <= @xObjects[i].y <= @center.y + @radius
                @xObjects[i].visibleY = true
                return true
        @yObjects[i].visibleY = false
        return false

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
