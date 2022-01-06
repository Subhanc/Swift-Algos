import Foundation


class ConnectFour { 
    var board: [[Int]] 
    var columns: [Int]
    let boardSize: Int
    
    let directions: [Direction] = [.horizontal, .vertical, .leftDiagonal, .rightDiagonal] 
    
    enum Direction: [[Int]] {
        case horizontal
        case vertical
        case leftDiagonal
        case rightDiagonal
        
        func getDirections(_ direction: Direction) { 
            switch direction { 
                case horizontal: 
                    return [[1,0], [-1, 0]]
                case vertical: 
                    return [[0, 1], [0, -1]]
                case leftDiagonal:
                    return [[1, 1], [1, -1]]
                case rightDiagonal:
                    return [[-1, 1], [-1, -1]]
            }
        }
    }
    
    enum GameState { 
        case invalidMove
        case win
        case validMove
    }
    
    init(_ boardSize: Int = 6) { 
        self.board = Array(repeating: Array(repeating: 0, count: boardSize), count: 0)
        self.boardSize = boardSize
        self.columns = Array(repeating: 0, count: boardSize) 
    }
        
    func move(_ player: Int, columnSelected: Int) -> GameState {
        if columnSelected < 0 || columnSelected > board[0].count || columnSelected[column] >= boardSize {
            return .invalidMove 
        }
        
        let x = columnSelected[column] 
        columnSelected[column] += 1
        board[x][y] = player
        return didWin(player, [x, y]) ? .win : .validMove
    }
    
    func didWin(_ player: Int, move: [Int]) -> Bool { 
        for direction in self.directions { 
            if check(player, move, direction) {
                return true
            }
        }
        return false
    }
    
    func check(_ player: Int, move: [Int], _ direction: Direction) -> Bool { 
        let directions = Direction.getDirections(direction) 
        
        var x = move[0] 
        var y = move[1] 
        var result = 0
        
        for direction in directions { 
            while x < board.count && x >= 0 && y < board[0].count && y >= 0 && board[x][y] == player { 
                result += 1
                x += direction[0]
                y += direction[1]

            }
        }
        if result >= 4 { return true } 
        return false 
    }
}
