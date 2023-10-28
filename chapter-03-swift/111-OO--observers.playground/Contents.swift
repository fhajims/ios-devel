// This source will appear in the
//   omd_ios-devel.pdf book
// Included with:
//   \lstinputlisting{\HERE/src/150_closure.playground/Contents.swift}
// 2016, jf
//
// in the pdf, we start at line 10 for OO: Lazy properties:


// Property Observers
public class Window{
    static let maxVal:Int=99
    // Attributes
    public var xPos:Int=0 {
        willSet(newValue) {
            print("We try to set attribute 'xPos'",
                "from current value \(self.xPos)",
                "to new value \(newValue)")
        }
        didSet(oldValue){
            print("We set attribute xPos to \(xPos)",
                  "(from old value: \(oldValue))")
            if xPos > Window.maxVal {
                xPos = Window.maxVal
            }
        }
    }
}
let helpAndDocu=Window()
helpAndDocu.xPos = 114 // watch the log: 'We try to set..'
print("We get capped value of: \(helpAndDocu.xPos)") // 99
