
// closures:
// { (params) -> returnType in
//   statements
// }
let authors = ["Jelinek", "Joyce", "Haas"]
let welcomeTexts = authors.map({
    (author: String) -> String in
    "Welcome, \(author)!"
})
print(welcomeTexts) // ["Welcome, Jelinek!", ...
// closure with inferred types
let someNumbers = [5,6,9,1,3]
let sortedNumbers = someNumbers.sorted(by:{s1, s2 in return s1>s2} ) // [6,5]
print(" We custom sort \(someNumbers) to get \(sortedNumbers)")
// closure/function with implicit parameter $0
let c = {$0 * 3}
c(4) // 12

let srtdNrs = [11,5,6,1].sorted {s1, s2 in return s1>s2}
print(srtdNrs)

let srtdNrsShorter = [11,5,6,1].sorted {$0>$1}
print(srtdNrsShorter)
