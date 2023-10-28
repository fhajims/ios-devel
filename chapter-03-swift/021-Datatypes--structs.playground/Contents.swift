import UIKit

// Prefer structs to classes
// structs are always copied,
// i.e. structs are passed by value
// Note the difference to instances of classes, which are passed by reference.

// All we need to define a struct.
// Note: with let the variables MUST not be changed later, with var variables might be changed later.
struct Biker{
    enum BikeType {
        case Mountainbike
        case CityBike
    }
    let name:String
    var score: Int
    var ridesTypeOfBike: BikeType = .Mountainbike
    init(name:String,score:Int,ridesTypeOfBike:BikeType = .CityBike){
        self.name = name
        self.score = score
        self.ridesTypeOfBike = ridesTypeOfBike
    }
    // very special: sometimes functions should change the inner value:
    mutating func changeTypeOfBike(newBikeType:BikeType){
        self.ridesTypeOfBike = newBikeType
    }
}

// An extension to "self-describe" an instance
// e.g. when printing out
extension Biker:CustomStringConvertible{
    var description: String {
        return "Hi, this is '\(name)' on a \(self.ridesTypeOfBike) with current score of '\(score)'."
    }
}

// an extension to change the way instances are sorted
// e.g. providing the operator "<" for the struct
extension Biker: Comparable {
    static func < (lhs: Biker, rhs: Biker) -> Bool {
        return lhs.score < rhs.score
    }
}


var bikers = [
    Biker(name: "Miriam", score: 19),
    Biker(name: "Nora", score: 27),
    Biker(name: "Adrian", score: 17, ridesTypeOfBike: .CityBike)
]
// careful with structs
// structs are are just copies. Original List keeps unchanged !!!
var adrian = bikers.last
adrian?.ridesTypeOfBike = .CityBike
var miriam = bikers.first
miriam?.changeTypeOfBike(newBikeType: .CityBike)

// careful with structs, modification means replacement!
// only if list "bikers" can be modified, i.e. is "var" (not "let"):
// replace an entry, such as the last one
if let bikerToReplace = adrian {
    bikers.popLast()
    bikers.append(bikerToReplace)
}

print("\nBikers:")
for biker in bikers {
    print(biker)
}
print("\nSorted Bikers:")
for biker in bikers.sorted() {
    print(biker)
}

print("\nBikers (sorted descending):")
for biker in bikers.sorted().reversed() {
    print(biker)
}
