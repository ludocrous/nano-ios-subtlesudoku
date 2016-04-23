//: Scratch area to experment with structures to convert Peter Norvig's Python implemenation of a Sudoku Solver into Swift 2.0+

import UIKit


let xc : Int = 0b111111111


let a = 0b1100
let b = 0b0110

let c = a ^ b

print(String(c,radix:2))


var myCell = SudoCell(gridRef: "A1")
myCell.possibleValues()
myCell.eliminatePossibleValue(3)
myCell.eliminatePossibleValue(6)
myCell.eliminatePossibleValue(7)
myCell.possibleValues()
myCell.isPossibleValue(1)
myCell.isPossibleValue(7)
myCell.setToSpecificValue(3)
myCell.possibleValues()
myCell.resetAllPossibleValues()
myCell.possibleValues()

//myCell.resetAllPossibleValues()
//myCell.countBitsSet(SudoAllValues)
//myCell.bitsAsString(myCell.pValues)
//myCell.bitsAsString(myCell.intToBits(8))

let refs = createRefs(Array(rows.characters), cols: Array(cols.characters))
refs.count

"Hello".dynamicType
"Hello".characters.dynamicType
let str: String = "Hello"
let chars = Array(str.characters)
chars.dynamicType

