//
//  SudoGrid.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 25/04/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import Foundation



public class SudoGrid  {
    
    var grid: [String:SudoCell] = [:]
    var problemValues: [String : Int] = [:]
    
    
    public var gridString: String {
        var gs: String = ""
        for cell in SU.cells {
            if let sc =  grid[cell] {
                gs += sc.gridStringValue
            }
        }
        return gs
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
                if eliminate(gridRef, entry: d2) == false {print("returning false from assign \(gridRef) with \(entry)");  return false }
            }
            return true
        } else {
            print ("Problem")
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
                if eliminate(s2, entry: d2!) == false {print("returning false from elimnate \(gridRef) with \(entry)");return false}
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
            print ("Solving for \(ref) with \(value)")
            if assign(ref, entry: value) == false {return false}
        }
        return true
    }
    
    func cellValueAtRef(gridRef: String) -> String {
        if let cell = (grid[gridRef]) {
            return cell.asSingleValueString("*")
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
        print ("Lowest tree count is \(minOptions) for \(minRef)")
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
        print ("Returning \(solved)")
        return solved
        
    }
}