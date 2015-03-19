
class Camera
    constructor: (width, height)->
        xObjects = []
        yObjects = []
        center = new Pixi.Point(0,0) # absolute coordinates
        boundingBox = new Pixi.Rectangle(center.x, center.y , width, height)
        xPointer= [0,0] #(first element, second element)
        yPointer= [0,0] #(first Element, second element)

    initGameObjects: (gObjectList)  ->
        @xObjects = []
        @yObjects = []
        
# Same Objects but different lists
        @xObjects.push elem for elem in gObjectList
        @yObjects.push elem for elem in gObjectList


    scroll:(delta) ->
        if delta[0] == 0 
            updateYObjects(delta[1])
        else if delta[1] == 0 
            updateXObjects(delta[0])
        else
            updateXObjects(delta[0])
            updateYObjects(delta[1])

    sortByY: ->
        
    _sortByX: ->

    _sortByY: ->




    

