import Foundation



public struct SudoGrid  {
    
    var grid: [String:SudoCell] = [:]
    
    
    public init() {
        for cell in cells {
            grid[cell] = SudoCell(gridRef: cell)
        }
    }
    
    public init(gridString: String) {
        assert (gridString.characters.count == 81, "Grid initialisers must have 81 elements only")
        let values = Array(gridString.characters)
        for i in 0..<81 {
            let cell: String = cells[i]
            let value = values[i]
            assert(Array("123456789.0".characters).contains(value))
            if [".","0"].contains(value) {
                grid[cell] = SudoCell(gridRef: cell)
            } else {
                grid[cell] = SudoCell(gridRef: cell, withValue: Int(String(value))!)
            }
        }
    }
}