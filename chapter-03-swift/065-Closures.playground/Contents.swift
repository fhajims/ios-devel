import UIKit

var greeting = "Code blocks / Closures"
print(greeting)

// - MARK: Demo data
let authors = ["Jelinek", "Joyce", "Haas"]
let listOfNumbers = [5,6,0,1,3,99,33,1,2]


// - MARK: pass code blocks / closures to functions
print("")
print("Code blocks can be passed to/from functions as arguments/parameters.")

func doSomething( msg:String, callCodeWithIntArg v:Int, codeblock: (Int) -> Bool  ) -> String {
    let result = codeblock(v)
    return " The provided codeblock to \(msg) called with argument \(v) returned: \(result)."
}
// define a code block we will use as parameter later on
let code:(Int)->Bool = { a in
    print(" DEBUG: we check if value \(a) is even")
    return a%2==0
}
// call function with code block as parameter
let res = doSomething(msg: "check if a number is even", callCodeWithIntArg:7, codeblock: code)
print(" The function doSomething(msg:callCodeWithIntArg:codeblock:) returned following string: '\(res)'.")

// - MARK: pass outside ()
print("")
print("Code blocks, if they are the last parameter, can be passed outside the braces () into a function.")
let isZero = doSomething(msg: "check if a number is zero", callCodeWithIntArg:7){ currVal in
    return currVal == 0
}
print(isZero)

// - MARK: implicit parameters: $0, $1, $2, ...
print("")
print("Implicit parameter names $0, $1, $2 used inside functions")
let isThisZero = doSomething(msg: "check if a number is zero", callCodeWithIntArg:0){ $0 == 0 }
print(isThisZero)

let c = {$0 * 3}
let resOfFunctionCall = c(4) // 12
print(" Calling c \(String(describing: c)) results in \(resOfFunctionCall)")


// - MARK: Functional: map, sort, ...

print("")
print("In functional programming (map, sort, filter, reduce, ...) many short-cuts are used with  functions/code-blocks/closures and it's arguments.")
let welcomeTexts = authors.map({
    (author: String) -> String in
    "Welcome, \(author)!"
})
print(" The mapped list of \(authors) returned: \(welcomeTexts)") // ["Welcome, Jelinek!", ...

// closure with inferred types
var sortedList = listOfNumbers.sorted(by:{elem1, elem2 in return elem1>elem2} )
    sortedList = listOfNumbers.sorted(){$0>$1}
print(" When sorting \(listOfNumbers) elem1 > elem2 (or $0>$1) we get: \(sortedList).")

print("Done")
