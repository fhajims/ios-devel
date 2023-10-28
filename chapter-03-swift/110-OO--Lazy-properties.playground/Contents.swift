// Lazy properties
// Further note:
//   by using self the closure would capture
//   a strong reference to its own object
//   so we need [unowned self]

class Book {
    
    var author: String
    
    lazy var titlePage: String = {
        [unowned self] in
        return "This is a book by \(self.author)!"
        }()
    
    init(author: String) {
        self.author = author
    }
}

let p=Book(author: "Maximilia")
print(p.author) // Maximilia

// only when using the attribute the codeblock
// after 'lazy var xxx = ' {...} gets executed
p.titlePage // This is a book by Maximilia!
