class GameOfLife
    currentCellGeneration: null # все клетки двумерного массива
    cellSize: 11
    numberOfRows: 40
    numberOfColumns: 100
    seedProbability: 0.1
    tickLength: 100
    canvas: null
    drawingContext: null
    timeout: 0
#  from_live_to_die:  '110011111'
#  from_die_to_live:'000100000'

    constructor: (width, height, cell, from_live_to_die, from_die_to_live) ->
        @cellSize = cell
        @numberOfColumns = width / @cellSize
        @numberOfRows = (height / @cellSize)
        @from_live_to_die = from_live_to_die.toString()
        @from_die_to_live = from_die_to_live.toString()

        @createCanvas()
        @resizeCanvas()
        @createDrawingContext()
        @seedWithDeadCellsOnly()
        @drawGrid()
#    @tick()

    getCurrentSellGeneration: ->
        @currentCellGeneration

    getAliveSells: ->
        @aliveSells = []

        for row in [0...@numberOfRows]
            for column in [0...@numberOfColumns]
                if @currentCellGeneration[row][column].isAlive
                    @aliveSells.push @currentCellGeneration[row][column]

        @aliveSells


    setPreset:(json) ->
        a = @currentCellGeneration
        $.each json, (key, value) ->
            a[value.y][value.x].isAlive = true
        @drawGrid()



    emptyField: ->
        @seedWithDeadCellsOnly()
        @drawGrid()

    demo: ->
        @seed()
        @drawGrid()

    startDemo: ->
        @seed()
        @tick()

    play: ->
        @tick()

    randomSeed: ->
        @seed()
        @drawGrid()

    pauseDemo: ->
        clearTimeout(@timeout)

    nextStep: ->
        @evolveCellGeneration()
        @drawGrid()


    setCell: (row, col) ->
        currCell = @currentCellGeneration[row][col]
        if (currCell.isAlive)
            currCell.isAlive = false
        else
            currCell.isAlive = true
        @drawCell(currCell)





    seedWithDeadCellsOnly: ->
        @currentCellGeneration = []

        for row in [0...@numberOfRows]
            @currentCellGeneration[row] = []

            for column in [0...@numberOfColumns]
                seedCell = @createCell row, column, false
                @currentCellGeneration[row][column] = seedCell


    createCell: (row, column, isAlive) ->
        isAlive: isAlive
        row: row
        column: column


    createCanvas: ->
        @canvas = document.createElement 'canvas'
        $("#div2").append @canvas
        $( "canvas" ).attr( "id", "div1" );
#        $(".container").append @canvas
#        document.body.appendChild @canvas


    resizeCanvas: ->
        @canvas.height = @cellSize * @numberOfRows
        @canvas.width = @cellSize * @numberOfColumns


    createDrawingContext: ->
        @drawingContext = @canvas.getContext '2d'


    seed: ->
        @currentCellGeneration = []

        for row in [0...@numberOfRows]
            @currentCellGeneration[row] = []

            for column in [0...@numberOfColumns]
                seedCell = @createSeedCell row, column
                @currentCellGeneration[row][column] = seedCell





    createSeedCell: (row, column) ->
        isAlive: Math.random() < @seedProbability
        row: row
        column: column


    drawGrid: ->
        for row in [0...@numberOfRows]
            for column in [0...@numberOfColumns]
                @drawCell @currentCellGeneration[row][column]


    drawCell: (cell) ->
        x = cell.column * @cellSize
        y = cell.row * @cellSize

        if cell.isAlive
            fillStyle = 'rgb(242, 198, 65)'
        else
            fillStyle = 'rgb(38, 38, 38)'

        @drawingContext.strokeStyle = 'rgba(242, 198, 65, 0.3)'
        @drawingContext.strokeRect x, y, @cellSize, @cellSize

        @drawingContext.fillStyle = fillStyle
        @drawingContext.fillRect x, y, @cellSize, @cellSize




    tick: =>
        @drawGrid()
        @evolveCellGeneration()

        @timeout = setTimeout @tick, @tickLength







    evolveCellGeneration: ->
        newCellGeneration = []

        for row in [0...@numberOfRows]
            newCellGeneration[row] = []

            for column in [0...@numberOfColumns]
                evolvedCell = @evolveCell @currentCellGeneration[row][column]
                newCellGeneration[row][column] = evolvedCell

        @currentCellGeneration = newCellGeneration




    evolveCell: (cell) ->
        evolvedCell =
            row: cell.row
            column: cell.column
            isAlive: cell.isAlive

        numberOfAliveNeighbors = @countAliveNeighbors cell
        if cell.isAlive == true
            if @from_live_to_die[numberOfAliveNeighbors] == '1'
                evolvedCell.isAlive = false
        else
            if @from_die_to_live[numberOfAliveNeighbors] == '1'
                evolvedCell.isAlive = true

        #    if cell.isAlive or numberOfAliveNeighbors is 3
        #      evolvedCell.isAlive = 1 < numberOfAliveNeighbors < 4

        evolvedCell

# живая: если клетка живая и число соседей 2, 3
# живая: если клетка метрвая но число соседей 3


    countAliveNeighbors: (cell) ->
        lowerRowBound = Math.max cell.row - 1, 0
        upperRowBound = Math.min cell.row + 1, @numberOfRows - 1
        lowerColumnBound = Math.max cell.column - 1, 0
        upperColumnBound = Math.min cell.column + 1, @numberOfColumns - 1
        numberOfAliveNeighbors = 0

        for row in [lowerRowBound..upperRowBound]
            for column in [lowerColumnBound..upperColumnBound]
                continue if row is cell.row and column is cell.column

                if @currentCellGeneration[row][column].isAlive
                    numberOfAliveNeighbors++

        numberOfAliveNeighbors


window.GameOfLife = GameOfLife




