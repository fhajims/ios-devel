---

---
#### [Home](../README.md) | [Overview-Mini-apps](../demo-apps.md)

---


# 3a Swift I (Basics)


For [Functions](./060-Functions.playground) (and method)

* you might use named parameters with different external name. Use the underscore `_` for not needing names for arguments when calling a function.
* you can set default values
* you might use `inout` parameters

Get used to define the functionality of instances using **Protocols**. Prefer **Structs** to **Classes**. For shorter code use **properties** instead of getter or setter functions. *Note, properties might optionally be provided with get or set funktionality later.*


**Secure coding** requires your understanding of **Type-safety**, ie. working with **Type Inference**, **Nullable Types**, and **Optional Chaining**. Check out the use of ```String?```, ```nil```, ```??```, and ```?.```.
 
#### Click to open a Playground

* [Structs](021-Datatypes--structs.playground) are preferred to classes. Code is short, but the instances are equipped with powerful functionality. Typically, in Swift additional functionality (even for existing structs, protocols, classes) can be add later by using **Extensions**

	* Use **convenient** initialisers (which are required to call the **designated** initialiser).
	* Write **extensions** to classes (to conform to protocols such as `CustomStringConvertible `, and `Comparable`).
	* For fix set of options, better use ```enums```, i.e. **enumerations**, (instead of strings) within structs or classes.
* [Optionals](045-Optionals.playground): Nullable types with `?` (e.g. `Page?`), optional chaining `?.` (e.g. `book.titlePage?.text`) .

* [Closure](./150-Closure.playground): Small code of blocks (similar to anonymous functions, but including the surrounding context) are called *closures*. Closures are very handy in functional programming where we pass functions as parameters. For example, pass some code as a closure to a  `sort` method. Thereby, you can specify the way a sort algo decides which of tho values is the larger one.
	* Specify sort and filter arguments as **closures**.
	* Hand over code as argument *after* the braces () to make your code prettier: `[11,5,6,1].sorted {s1, s2 in return s1>s2}`
	* Use implicit variables for short code within closures, e.g. ```[11,5,6,1].sorted {$0>$1}```



# 3b Swift II (Advanced)

More powerful Swift features.

Pasing code blocks is possible with [Closures](./065-Closures.playground).

The Swift programming language allows to **code in a very secure** way. Use **Guard** statements to make your code easy to read and secure at the same time.

No need to implement own code for **observing state**. Observable properties are built-in. Use ```WillSet``` and ```DidSet``` to observe state changes.

In some cases, you migth optimise performance using **Lazy** properties.

**Operator overloading** might be useful for sorting. For example, write extension to classes to conform to protocols such as `Comparable` and overload the `<` operator: ```static func < (lhs: Biker, rhs: Biker) -> Bool {...```.

**Generics** ```<T>``` might save you writing lots of code (when you need the same functionality for different data types). The special keyword `any` is necessary for *existential types* (e.g. `let note: any Message = SecureMessage() `) and the keyword `some` (`func send(msg: some Message)  {...`) is a shortcut for defining a type of *something conforming to a protocol* (e.g. `func send<T>(msg: T) where T: Message  {...`).


To keep UIs responding, you need to know how to work with **Concurrency**. Swift provides **suspendable functions** with *async/await* built in.


####  Click to open a playground

Error Handling:

* [Guard](./060b-Error-handling--guard.playground): At the *beginning* of a function, check (user) input and return early if any parameter has an unexpeced value.
* [Property Observers](./111-OO--observers.playground): When inner values (*properties* of an instance) are changed, code can be executed. Override the `willSet` and/or the `didSet` methods for a property.

* [Lazy Properties](./110-OO--Lazy-properties.playground): An actual value is set to the property **on first use**. You are expected to know how the garbage collector works, because **Automatic Reference Counting** (ARC) requires you to use in some locations **unowned** references.  


* [Singleton Design Pattern](./710-Design-Patterns--Singleton.playground): To make sure only one instance of a class exists. For the singleton design pattern we use ```static let sharedInstance = SoundPlayer()``` and use it like ```let sp = SoundPlayer.sharedInstance)```



---
#### Proceed to [Chapter 04 Data Modelling](../chapter-04-data-modelling/README.md) | Back to [Chapter 02 Testing](../chapter-02-testing/README.md)

---