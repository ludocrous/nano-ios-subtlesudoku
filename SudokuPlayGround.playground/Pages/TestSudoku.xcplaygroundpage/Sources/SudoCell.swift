import Foundation

typealias SudoBits = UInt16
let SudoAllValues : SudoBits = 0b111111111

public struct SudoCell: CustomStringConvertible {
    
    var pValues: SudoBits = SudoAllValues
    let gridRef: String
    //var isLocked: Bool = false
    
    
    public var description: String {
        let possVal = possibleValues()
        var outStr = ""
        for val in possVal {
            outStr += "\(val)"
        }
//        return "\(gridRef) - " + outStr
        return outStr
    }
    
    func bitsAsString (bits : SudoBits ) -> String {
        
        let bitStr = String(bits, radix:2)
        return bitStr.characters.count < 9  ? String(count: 9 - bitStr.characters.count, repeatedValue: UnicodeScalar("0")) + bitStr : bitStr
    }
    
    // As most of the time the bulk of the bits will be zero this should be more effecient than a full popcount algo.
    func countBitsSet (bits: SudoBits) -> Int {
        var value = bits
        var count: Int = 0
        while value != 0 {
            value &= value - 1
            count += 1
        }
        return count
    }
    
    func intToBits (number: Int) -> SudoBits {
        assert((1...9).contains(number), "Must be between 1 and 9")
        return  SudoBits(1 << (number - 1))
    }
    
    public mutating func resetAllPossibleValues() {
        pValues = SudoAllValues
    }
    
    public func isPossibleValue(value: Int) -> Bool {
        return pValues & intToBits(value) != 0
    }
    
    public func possibleValues () -> [Int] {
        var result = [Int]()
        for i in 1...9 {
            if isPossibleValue(i) {
                result.append(i)
            }
        }
        return result
    }
    
    public mutating func setToSpecificValue(value: Int, startingValue: Bool = false) {
        if startingValue {
      //      initialValue = value
        }
        pValues = intToBits(value)
    }
    
    public mutating func addPossibleValue(value: Int) {
        pValues |= intToBits(value)
    }
    
    public mutating func eliminatePossibleValue(value: Int) {
        pValues &= ~intToBits(value)
    }
    
    
    public init (gridRef: String, withValue value : Int = 0) {
        assert(gridRef.characters.count == 2, "Grid references must be 2 chars in the format A1 , G3 , etc")
        self.gridRef = gridRef
        if (value > 0 && value <= 9) {
            setToSpecificValue(value)
        }
    }
    
}
