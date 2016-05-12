//
//  SudoUtils.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 25/04/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import Foundation

typealias SU = SudoUtils

struct SudoUtils {
    static let numberColumns: Int = 9
    static let numberRows: Int = 9
    static let cols = "123456789"
    static let colsArray = Array(cols.characters)
    static let digits = cols
    static let digitsArray = Array(digits.characters)
    static let rows = "ABCDEFGHI"
    static let rowsArray = Array(rows.characters)
    static let entries = 1...9
    static var cells = [String]()
    static var units = [[String]]()
    static var membership = [String: [[String]]]()
    static var peers = [String: [String]]()
    
    
    static func createRefs (rows rows: [Character], cols: [Character]) -> [String] {
        var result = [String]()
        for r in rows {
            for c in cols {
                result.append(String(r) + String(c))
            }
        }
        return result
    }
    
    static func validCount(gridString: String) -> Int {
        var count = 0
        for char in gridString.characters {
            if digitsArray.contains(char) {
                count += 1
            }
        }
        return count
    }

    static func buildRelationships() {
        cells = createRefs(rows: Array(rows.characters), cols: Array(cols.characters))
        
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
                err("Problem - this should not be nil")
            }
        }
    }
}
