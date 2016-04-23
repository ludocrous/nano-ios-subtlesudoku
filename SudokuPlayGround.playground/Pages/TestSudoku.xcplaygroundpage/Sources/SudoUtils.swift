import Foundation

public func createRefs (rows rows: [Character], cols: [Character]) -> [String] {
    var result = [String]()
    for r in rows {
        for c in cols {
            result.append(String(r) + String(c))
        }
    }
    return result
}


public let numberColumns: Int = 9
public let numberRows: Int = 9
public let cols = "123456789"
public let colsArray = Array(cols.characters)
public let rows = "ABCDEFGHI"
public let rowsArray = Array(rows.characters)
public let entries = 1...9
public let cells = createRefs(rows: Array(rows.characters), cols: Array(cols.characters))
public var units = [[String]]()
public var membership = [String: [[String]]]()
public var peers = [String: [String]]()
public func buildRelationships() {
    for c in colsArray {
        let result = createRefs(rows: rowsArray, cols: Array(arrayLiteral: c))
        units.append(result)
    }
    for r in rowsArray {
        let result = createRefs(rows: Array(arrayLiteral: r), cols: colsArray)
        units.append(result)
    }
    for r in ["ABC", "DEF", "GHI"] {
        for c in ["123","456","789"] {
            let result = createRefs(rows: Array(r.characters), cols: Array(c.characters))
            units.append(result)
        }
    }
    
    for cell in cells {
        membership[cell] = [[String]]()
    }
    
    for cell in cells {
        for u in units {
            if u.contains(cell) {
                membership[cell]?.append(u)
            }
        }
    }
    for cell in cells {
        var cellSet = Set<String>()
        if let members = membership[cell] {
            for entries in members {
                let entrySet = Set(entries)
                cellSet = cellSet.union(entrySet)
            }
            let index = cellSet.indexOf(cell)
            cellSet.removeAtIndex(index!)
            peers[cell] = Array(cellSet)
        } else {
            print("Problem - this should not be nil")
        }
    }
    
    
}
