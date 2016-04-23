import Foundation

public let numberColumns: Int = 9
public let numberRows: Int = 9
public let cols = "123456789"
public let rows = "ABCDEFGHI"

public func createRefs (rows: [Character], cols: [Character]) -> [String] {
    var result = [String]()
    for r in rows {
        for c in cols {
            result.append(String(r) + String(c))
        }
    }
    return result
}

public struct SudoGrid  {
    
    
    
}