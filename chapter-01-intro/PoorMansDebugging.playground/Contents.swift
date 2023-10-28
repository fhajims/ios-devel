import UIKit

print("Poor Man's Debugging with print statements.")


var warning = "Your password is not very secure."

// bad: plain output
print(warning)
// better: add explanation
print("Warn: \(warning)")
// best: make output value visible and give context
print("In main function, the warning message  is '\(warning)'.")


// Note: output with empty strings
warning = ""
print(warning)
print("Warn: \(warning)")
print("In main function, the warning message  is '\(warning)'.")

struct Message {
    let warn = "Your password is not very secure."
    let suggest = "Add more chars for a longer password."
}
let m = Message()

print("Show inner status with dump:")
dump(m)
