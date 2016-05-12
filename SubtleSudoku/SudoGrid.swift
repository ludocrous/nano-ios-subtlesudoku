//
//  SudoGrid.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 25/04/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import Foundation



public class SudoGrid  {
    
    //This class constitutes the 9 X 9 sized 81 element grid synonomous with Sudoku
    
    var grid: [String:SudoCell] = [:]
    var problemValues: [String : Int] = [:]
    
    
    //Extract the current state of teh grid using digits for solved values and . for those with numerous possible values
    public var gridString: String {
        var gs: String = ""
        for cell in SU.cells {
            if let sc =  grid[cell] {
                gs += sc.gridStringValue
            }
        }
        return gs
    }
    
    // Which values has the user entered ie not part of the original puzzle
    var userEntryString: String {
        var ps: String = ""
        for cell in SU.cells {
            if let sc =  grid[cell] {
                if !isOriginalCell(sc.gridRef) {
                    ps += sc.gridStringValue
                } else {
                    ps += "."
                }
            }
        }
        return ps
    }
    
    private init() {
        for cell in SU.cells {
            grid[cell] = SudoCell(gridRef: cell)
        }
    }
    
    public init(gridString: String) {
        assert (gridString.characters.count == 81, "Grid initialisers must have 81 elements only")
        let values = Array(gridString.characters)
        for i in 0..<81 {
            let cell: String = SU.cells[i]
            let value = values[i]
            assert(Array("123456789.0".characters).contains(value))
            if [".","0"].contains(value) {
                grid[cell] = SudoCell(gridRef: cell)
            } else {
                problemValues[cell] = Int(String(value))
                grid[cell] = SudoCell(gridRef: cell) // , withValue: Int(String(value))!)
            }
        }
    }
    
    //MARK: Code to progressively analyse puzzle
    
    func setValue(gridRef: String, entry: Int) {
        guard(grid[gridRef] != nil) else {err("Invalid grid ref "); return}
        switch entry {
        case 1...9 :
            grid[gridRef]!.setToSpecificValue(entry)
        default:
            grid[gridRef]!.resetAllPossibleValues()
        }
    }
    
    func applyProblemValues() {
        for (ref, value) in problemValues {
            setValue(ref, entry: value)
        }
    }
    
    func cellValueAtRef(gridRef: String) -> String {
        if let cell = (grid[gridRef]) {
            return cell.asSingleValueString("")
        } else {
            return ""
        }
    }
    
    func isOriginalCell(gridRef: String) -> Bool {
        if let _ = problemValues[gridRef] {
            return true
        } else {
            return false
        }
    }
    

    
    //MARK: Code to solve puzzle completely
    
    var solved: Bool {
        for (_,cell) in grid {
            if cell.possiblesCount != 1 {return false }
        }
        return true
    }
    
    func assign (gridRef: String, entry: Int) -> Bool {
        if var cell = grid[gridRef] {
            cell.eliminatePossibleValue(entry)
            for d2 in cell.possibleValues {
                if eliminate(gridRef, entry: d2) == false {err("returning false from assign \(gridRef) with \(entry)");  return false }
            }
            return true
        } else {
            err ("Problem")
            return false
        }
    }
    
    
    func eliminate (gridRef: String, entry: Int) -> Bool {
        if grid[gridRef]?.isPossibleValue(entry) == false {
            return true //Already gone !
        }
        
        grid[gridRef]?.eliminatePossibleValue(entry)
        
        let possCount = grid[gridRef]?.possiblesCount
        if possCount == 0 {return false } //Problem
        else if possCount == 1 {
            let d2 = grid[gridRef]?.possibleValues[0]
            for s2 in SU.peers[gridRef]! {
                if eliminate(s2, entry: d2!) == false {err("returning false from eliminate \(gridRef) with \(entry)");return false}
            }
        }
        for members in SU.membership[gridRef]! {
            var placeCount = 0
            var entryPlace: String = ""
            for gr in members {
                if ((grid[gr]!.isPossibleValue(entry))) {
                    placeCount += 1
                    entryPlace = gr
                    
                }
            }
            if placeCount == 0 {return false } // Nowhere for number to go
            else if placeCount == 1 {
                if assign(entryPlace, entry: entry) == false { return false}
            }
        }
        return true
    }
    
    public func solve() -> Bool {
        for (ref,value) in problemValues {
//            dbg ("Solving for \(ref) with \(value)")
            if assign(ref, entry: value) == false {return false}
        }
        return true
    }
    
    public func searchSolve() -> Bool {
        if solved {return true}
        
        var minOptions = 10
        var minRef = ""
        for (ref,cell) in grid {
            let possCount = cell.possiblesCount
            if possCount > 1 && possCount < minOptions {
                minOptions = possCount
                minRef = ref
            }
        }
//        dbg ("Lowest tree count is \(minOptions) for \(minRef)")
        let poss = grid[minRef]!.possibleValues
        for possValue in poss {
            let gridCopy = grid
            if assign(minRef, entry: possValue) {
                searchSolve()
            }
            if !solved {
                grid = gridCopy
            }
        }
//        dbg ("Returning \(solved)")
        return solved
        
    }
}