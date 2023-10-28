---

--- 
##### [Home](./README.md) | [Overview](./study-material--overview.md)

---


# Part A: Swift


> "Most good programmers do programming not because they expect to get paid or get adulation by the public, but because it is fun to program." — Linus Torvalds


**Motivation:** How can I write readable (`enums`), maintainable (`protocols`, `extensions`) and secure code with Swift using **immutable** values (`let`, `struct`, value-objects) and use **null safety** checks to detect if *optionals* contain values (exit early with `guard let`)?  

## Memory Management

* Automatic Reference Counting **ARC**
	* for garbage collection gc
	* each (normal) reference to an object is a **strong reference** 
	* for ARC the **compiler inserts statements** into the source code. Statements are added for increasing and decreasing the strong reference counters. The counter is called **retain count**. For example, code for decreasing the counter is inserted for a variable at the location in the code where the variable goes out of scope.
	* gc is done (memory is released, i.e. deallocated), when the reference counter for an object goes down to 0.
* References to objects might be
	* **strong**, i.e. strong references increases/decreases the reference counter
	* **weak** references will not increase/decrease reference counter. That is to avoid strong reference cycles, where the memory would never be released. Possibly, the object a weak reference is pointing to, might already be deallocated and set to nil.
	* **unowned** references will not increase/decrease reference counter. For unowned references no optional chaining is necessary, as we **expect** the unowned reference to always point to still existing object in memory. *Note: the developer has to take care of it, otherwise the object an unowned reference is pointing to, might already be unintentionally deallocated and set to nil and application crashes.*
* Life time
	* **closures** are different to functions insofar, as closures are code blocks which *include* the variables/values of the scope where the code block has been defined. Closures passed into a function must be marked `@escaping`, when they live longer than the function (they get passed to) itself. To *outlive* means to **escape** the function scope.

* Compiling / optimisation
	* **LLVM**: The Low Level Virtual Machine Infrastructure compiles Swift Source Code into **executable binaries** (different for each ARM/Intel/AppleSilicon platform) or into **bitcode** which might be optimised and (re-) compiled in the App Store before download.
	
## Modern Language Features

* Swift supports **functions** with **named arguments** and **default parameters**. Internal and external names for parameters are possible. An external name can be suppressed by using an underscore `_`. 
	
	```swift
	func power( _ b:Int,   // external name = _ = not needed
	            exp:Int,   // named with default value
	            msg:String)
	            -> (powRes:Int,   // named return value
	                powMsg:String){
		... 
	   // returning a tuple
	    return (r,"\(msg) \(r)")
	}

	let res = power(6,msg:"The final result is")
	print(res.powMsg) 
	```
* Furthermore, call-by-value is default, but **call-by-reference** with `inout` parameters and varags are supported. **Nested** functions and passing functions as arguments are supported, too. If the last argument is an code block, it can be passed outside the closing brace `)`.

* Find first demos in [Part 3 Swift](./chapter-03-swift/README.md). There are playground demos, such as [functions](./chapter-03-swift/060-Functions.playground) and [closures](./chapter-03-swift/065-Closures.playground).

## Differences to some other Languages

* **Strong Typing**
	* the compiler ensures that each variable has a fixed type and that a variable will never be assigned a value of another type.   
* **Type Inference**
	* the compiler detects and sets the type of a variable (when a variable is declared and defined), for example `let counter = 0` will set the type of variable counter to `Int`. 
* Protocols
	* define behaviour of *class*es and *struct*s. Technically, it specifies *names* and *types* of methods and parameters 
* Structs 
	* similar to classes, BUT 
	* structs are **value type**s (e.g. an instance of a struct is passed as a **copy** into a function)
* Classes
	* **reference type** (passed around as **reference**, instances of classes get *not* copied)	
	* single inheritance
	* **designated initialisers** are the primary, the main constructors `init(...){...}`. Further constructors are called **convenience** initialisers `convenience init(...){...}`. Convenience initialisers must call a designated initialiser. 
	* operator overloading
* Extensions
	* add methods to existing (even built-in) structs, classes or protocols 
* Lazy properties
	* initialised on first usage. The initialisation is delayed, ie. the code which assigns the value is not called  at definition time, but at a later point in time (on first use, on demand).

* Find demos on basic Swfit features in playgrounds for [Part 3 Swift](./chapter-03-swift/README.md). For example, there are playground demos on [Structs](./chapter-03-swift/021-Datatypes--structs.playground), [Classes (with lazy properties)](./chapter-03-swift/110-OO--Lazy-properties.playground), [Closure](./chapter-03-swift/150-Closure.playground).

## Programming Patterns

* Property observers
	* code (callbacks) gets executed when the value of a property changes

* Concurrency
	* **async/await** implemented by suspendable functions, by **coroutines**
	* previously, *Grand Central Dispatch (GCD)* used dedicated **threads** (and/or thread pools)

	* Details on **structured concurrency**:
		* Idea: developers can write code similar to structured programs, but parts might be exectued (quasi-)parallel. (This should be easier to understand, debug, and maintain than *unstructured concurrency* with callbacks).
		* **Tasks** are nested into **task trees**. This allows to cancel all (nested) concurrent functions (in a structured way) if an error occurs.
		* The Swift keyword **async** is used to indicate function/methods/code-blocks which can be suspended. 
		* The Swift keyword **await** allows to block execution of code until concurrent started functions finish and return a result.
		* Error handling with **try?** is supported by the Swift programming language. For example, use `let res = try? await f()` and `async let res = try? f()`.
		* To **synchronise** concurrent functions (and avoid data races), **actors** can be used. Methods of an actor are synchronised.
	* Find out how to take advantage of structured concurrency for background tasks in [Part C Apps: Background Tasks](./study-material--part-C-Apps.md) and for consuming web services in [Part D APIs Consuming Web Services](./study-material--part-D-APIs.md). A [demo app for consuming a JSON web service](./chapter-06-concurrency/Concurrency/README.md) can be found in [Chapter 6 Concurrency](./chapter-06-concurrency/README.md). 

	

* Delegate Pattern
	* delegate calls to other instances/objects, instead of handling it internally. **Delegation is often used instead of inheritance** (inherit features from a base class).    

* Singletons
	* If only *one* instance of a class is allowed, then hide the constructor by defining it private `private init(){}` and accessing the instance via a static property, such as `var let shared = DBMgr()`. Use the single instance within any location of your code with `let obj = DBMgr.shared`.
	* use singletons seldom and wisely.

* Find useful demos in the provided playgrounds. For example, how to use the [Singleton](./chapter-03-swift/710-Design-Patterns--Singleton.playground) and [Observer](./chapter-03-swift/111-OO--observers.playground) design pattern.

## Security Features

* Immutables
	* immutables can never be changed at runtime. No side-effects, e.g. an advantage for concurrency is, that (many) synchronisation problems can be avoided. 
	* variable declared with **`let`** (not with **`var`**) are immutable
	* `structs` are immutable
	* `enums` are immutable
	* **prefer immutable variables** for security and performance reasons
	* **prefer immutable data** (structs) over mutable data (classes, i.e. reference to objects), because multiple references to same memory location might cause concurrency troubles, such as accessing/manipulating the same data in memory from multiple threads and overwriting each other.

	 
* Nullability
	* **optionals** (i.e. a variable of type `var msg = String?`) might be `nil`, hence **better use variables of type optional only if really necessary**. E.g. if you manage your address you might or might not know your GPS location front up. In this case it is perfectly ok to start with setting a varibale to nil indicating no value is available at the moment: `var gps:GPS? = nil`.

* Null safety
	* to make **null checking** easier (and safe)
		* use optional chaining, such as `msg?.title`
		* check early (first statement in a function/method) with `guard let` and exit function/method otherwise
			
			```swift
			guard let m = msg else { return } 
			print(m.title)
			...
			``` 

		* or use `if let` to convert a variable of an optional type into a new variable (optionally, with the same name) which is strict typed, such as 
			
			```swift
			if let m = msg { 
				print(m.title) 
				...
			```
			 
	* one might **force unwrap** an optional value, e.g. a varaible `msg` of type `String?` using the exclamation mark `msg!`. This is **very dangerous** and should be avoided in any case.

* Find also the advanced demos in [Part 3 Swift](./chapter-03-swift/README.md). For example, there are playground demos on how to use the [optionals](./chapter-03-swift/045-Optionals.playground) and the [guard](./chapter-03-swift/060b-Error-handling--guard.playground) statement.


## For Experts: 

> "If you sense there must be more, there is more." — Alan Cohen

### Special language feature: Key-Path

* properties can be accessed not only via the dot notation `o.m()`, but also via key(pathes) `o[\.m]`. Note the backslash dot making the expression `\.m` a key path.
	
### Swift and Objective-C APIs

* Swift can interact with the Objective-C runtime
	* Objective c looks up methods dynamically at runtime 
* Selectors 
	* are used to look up method names
	* selectors are created at compile time, so the compiler can ensure existance of methods
	* usage:
		* First, annotate methods with `@objc`, for example:
		* ```...@objc func closeAction() {...``` 
		* Then, lookup names using `#selector(`, for example:
		* ```UIBarButtonItem(barButtonSystemItem: ... action: #selector(closeAction))```

--- 
##### [Part B: Tools](./study-material--part-B-Tools.md).

---
