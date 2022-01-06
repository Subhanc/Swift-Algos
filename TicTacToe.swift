class TicTacToe {
    var rows: [Int]
    var cols: [Int] 
    var diagonal: Int
    var antiDiagonal: Int
    
    let boardSize: Int

    init(_ boardSize: Int) {
        self.rows = Array(repeating: 0, count: boardSize) 
        self.cols = Array(repeating: 0, count: boardSize) 
        self.boardSize = boardSizee
    }
    
    // 0 - game conintues
    // 1 - player 1 wins
    // 2 - play 2 wins
    public func move(_ row: Int, _ col: Int, _ player: Int) -> Int {
        let toAdd = player == 1 ? 1 : -1;
        rows[row] += toAdd;
        cols[col] += toAdd;
        if row == col{
            diagonal += toAdd;
        }
        if row + col == rows.length + 1 {
            antiDiagonal += toAdd;
        }
        
        if abs(rows[row]) == boardSize || abs(cols[col]) == boardSize || abs(diagonal) == boardSize || abs(antiDiagonal) == boardSize {
            return player;
        }
        return 0;
    }
}
