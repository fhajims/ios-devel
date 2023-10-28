import UIKit

// Singletons:
class SoundPlayer {
    var title = "Sound Player"
    private init() {}
    static let sharedInstance = SoundPlayer()
}
// add to class pretty print functionality:
extension SoundPlayer: CustomStringConvertible {
    var description:String {
        return "The SINGLE \(self.title)"
    }
}
let sp = SoundPlayer.sharedInstance
sp.title = "Instance of a Sound Player"
print(sp) // prints: The SINGLE Sound Player

let anotherSp = SoundPlayer.sharedInstance
print(anotherSp)
// Note: anotherSP is the same as the original sp
print("Check, if same: sp === anotherSp: '\(sp === anotherSp)'.")
