
class Task
    constructor: (@name) ->
        @status = 'incomplete'

    complete: ->
        @status = 'complete'
        return true


module.exports = {
    Task 
}

