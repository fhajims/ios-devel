// Correctness of Swift code can be
// inforced in many ways by the compiler.

// For example, normally a nil (null) value is just not allowed.

// Using Optionals, programmers must EXPLICITLY indicate, when a variable can be set to nil.

// This allows a much safer way to code!


// Optional Type "TitlePage?"
// i.e. variable "titlePage" could be "nil"
class Book{ var titlePage:TitlePage?}

class TitlePage{ var text="Don't Panic!"}

let guideToTheGalaxy = Book();
guideToTheGalaxy.titlePage=TitlePage()

// optional chaining with "?."
// No error, no "null" exception can occur, because if titlePage is nil, the attribue text is not envoked (not called).

if let txt = guideToTheGalaxy.titlePage?.text {
    print("On the tile is written '\(txt)'.")
} else {
    print("There is no title page for this book.")
}

