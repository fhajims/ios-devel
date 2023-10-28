---

---
#### [Home](./README.md) | [Overview](./study-material--overview.md)

---




# Possible Exam Questions

> "Software is hard. It’s harder than anything else I’ve ever had to do." — Donald Knuth
 



The answers to following questions can be found in the [Study Material](./study-material--overview.md).

Hint: Explain your answers to a fellow student!
 
## Chapter 1 Overview & Architecture

* How does the **architecture of iOS apps** differ from typical Android-Apps?
* Which **design patterns** are recommended when coding for iOS?
* Explain *singletons*, *delegates*, *observers*, and *dependency injection* and possible alternatives with the advantages and disadvantages.
* What is the main entry point into an app (Note annotation `@main`) and what are *targets*, what are *plist* files used for?
* Explain the difference between permissions granted at install time and runtime permissions. Give examples.
* Could you explain terms such as assets, schemes, and — used in older projects -  a storyboard? 
* Could you name the main development, debugging, (beta) testing and app store distribution tools used by an iOS development team including their relevant features? 
* Which unique ids and which certificates are necessary for development, signing and distribution?

## Chapter 2 watchOS

* How to communicate  between iOS app and watchOS app?
* Explain the type of connection.
* Describe, how to esablish a connection and how to send/receive data.

## Chapter 3 Swift Programming – Basics


* Explain some of the key language features of Swift. For example: **type inference**, strong typing, automated reference counting (**ARC**). Compare the features (e.g. protocols) to other languages.
* Can you show the usage of object-oriented programming (including initialisers, inheritance, **protocols**, **extensions**, **lazy properties**, …) in the Swift programming language?
* Are `struct`s or `class`es **passed by value**? Explain the (dis-) advantages to **pass by reference**.
* What is special with **Optionals** and with **optional chaining**?
* Could you explain and give examples of **weak** and **strong references**? 
* What are **named arguments** and **default parameters** for functions?
* Name two ways to pass a **code block** / **closure** to a function.


## Chapter 4 Swift Programing – Advanced

* Can I explain and demo advanced features of the Swift programming language: generics, **operator-overloading**, …
* Could you explain the usage, the advantages and disadvantages of advanced Object Oriented Programming (OOP) with Protocols and Extensions compared to Java OOP with interfaces? 
* Explain the differences between *designated initialiser* (`init(){..`) and *initialiser* (`convenience init(){..`).
* What is special with **property observers**? 
* Why would many consider `let` more secure than `var`?
* Argue for the usage of `guard let` over `if let`. 
* Could you explain the structure of the Low Level Virtual Machine Infrastructure (**LLVM**) and the tasks done by the single components? 
* What are the (practical) differences of classical vs. automatic reference counting (**ARC**) garbage collection implementations? 

## Chapter 5 iOS GUIs, Navigation, and Accessibility

* Explain what is necessary to create interfaces in SwiftUI. 
* An app used a body of type `Scene`, a View uses the body of type `View`. Could you explain the difference? 
* Explain the use of `NavigationView` and `NavigationLink` for presenting details of 
* Give an example, of how to code an interface with (nested) views.
* How can developers assign code for life-cycle methods (view appears) and user interactions (swipe gestures, tap a button).
* Name ways for **navigation**, and explain how to **pass data** from one view to another.
* Explain how (two-way) **data binding** works with SwiftUI views.
* How to define automatic updates using the `@Published` annotation. Explain the term **Single source of truth**.
* Give examples of when and how to you use annotations (e.g.: `@State` versus `@Binding`) for SwiftUI data binding.
* What is a use case for the annotation `@StateObject`, what is a use case of `@EnvironmentObject`.
* In which way will you add help for disabled people by using accessibility features?
* Could you explain the most important **life-cycle** events?

## Chapter 6 Concurrency and Web Services

* How to keep the UI responsive with background tasks for longer operations?
* How to retrieve data in the background from web services?
* Explain the use of **suspendable functions**: `Task{...}` and  `async` ... `await`. Especially, explain `async throws` ... and `try? await`.
* How and why are ReSTful web services called **asynchronously** (in concurrent threads)?
* Explain ways of **JSON serialisation** and the elaborate on the problem of type checking? 
* How can you use Grand Central Dispatch (**GCD**) to prevent blocking UIs and to how to improve performance?
* Explain the difference (advantages) of working with **async/await** in comparison to explicit working with **queues** (*`DispatchQueue.main.async \{..\}`*).
* State differences (including priority) between available custom and default **queues**?
* What is meant by Quality of Services (**QoS**)? Which requirements for GUI updates exists?
* Which concurrency problem can be solved with the use of annotation `@MainActor`?  



## Chapter 7 Saving State and Persistency

* Name three different ways to persist data.
* How to setup the O/R-Mapping (ORM) and how to update a schema?
* For which kind of data is it necessary to use secure storage?
* Explain the disadvantage of keeping data in a keystore?
* Where and how to define O/R-Mapping?
* What is the difference between eager and lazy loading! 
* Which consequences for security can we expect, when storing data into CoreData, UserDefaults and **Keystore**?
* Could you lay out use-cases for documents in the cloud and synchronisation needed? 


## Chapter 8 Location Based Services

* How to minimize user input? How to suggesting location, movement and context?
* What is necessary to use maps and add custom landmarks and points-of-interest (POIs)?
* How to use existing web services to improve user-experience?
* * Could you explain the usage, the advantages and disadvantages of Location Based Services concerning privacy?
* What differences are between *Overlays*, *Pins*, *Placemarks* and *Map Items*?
* Which accuracy can we expect from different ways of determining the location of a user? 
* Could you name the idea and application of **geofencing**?
* What are the (practical) limitations of the **(reverse) geocoding**? 

## Chapter 9 2D Graphics and Animation

* In which way are custom drawing possible and how to setup a *game-loop* ?
* Which frameworks are useful for 2D, which for 3D, which one for high performance?
* Which conceptual differences are between **Core Animation** and Sprite Kit? 
* Which conceptual differences are between the OpenGL ES, Metal and Unity Framework?
* Explain in detail the "optimal" frame rate and the ideas of **double buffering**. 

## Chapter 10 Sensors and Actuators

* Explain the advantages and disadvantages (according to a context) of polling versus callbacks to retrieve sensor data.
* How and when to employ different sensors (and different frameworks)? (Proximity, Ambient Light, ...) to provide feedback to users?
* Could you explain the usage, the advantages and disadvantages as well as the proper technical terminology for at least two actuators and five sensors?
* What is special (concerning the performance, power, connection time, kind of connection, security, ...) about bluetooth low energy  (**BTLE**)?

## Chapter 11 iOS (Operating System) Security and Insecurity, Forensics and App Analysis

* What does it mean to code in a secure way? Give 3 examples!
* How and where to save client data (user credentials) in a secure way?
* Why and how is code quality related to security?
* How can usability build trust, and could you as developer care for user privacy?
* Which steps are necessary/possible for an *.ipa debugging session?
* Explain the deployment certificates needed to put an app to the App Store?
* Could you draw the architecture and flow during usage of the **TouchID** and/or **FaceID** **biometric sensors**? 
* Which limitations and restrictions are necessary for **inter-app communication**?
* Name ways for inter-process communication (**IPC**) and known is uses?
* Explain the weaknesses of **URL schemes** on iOS in comparison to Android?
* Could you discuss the different approaches of **separating apps** on Android and on iOS including the consequences?
* Can you explain the terms and specific tasks of **Secure Enclave**.
* What do you know about the usage and status Possible Denyable Encription (PDE). 

## Chapter 12 System Services and Social Frameworks

* Name and explain kinds of data exchange (not) possible between apps and the system, such as clipboard, file system, inter-process communication (IPC). Explain consequences to security and privacy. How are restrictions enforced?
* How to integrate App logic with system services such as AddressBook, PhotoAlbum or Calendar? Could you sketch the steps for accessing contacts?
* In which ways it is possible to integrate social media services for sharing or login?
* Which way of communication from iOS to watchOS can be implemented? 
* Explain the basic concepts of selected IPC methods, such as **kernel queues, signals, sockets/ports, streams, pipes, or shared memory**. 

## Chapter 13 Cloud Services, Monitoring, and Testing

* Which Apple cloud services are available to developers and how to integrate them into own apps? Name limits and consequences, state ways to store documents transparently in the cloud.
* Can you explain at least three ways of synching to iCloud?
* Which privacy and security issues have to be considered?
* How to **test asynchronous code**?
* What are the requirement for stable **UI-Tests**? What are the limits for UI-Testing?
* Which drawbacks concerning performance, security, footprint, cross platform usage are to expect with different cloud service providers?
* How could a cloud based password store be safe? 

## Chapter 14 Local and Remote (Push) Notifications

* What are the important elements of the Apple **push notification architecture**? 
* Could you name the main differences between the Apple, Google and Microsoft Push Services?
* State ways to consume the notification inside the client app?
* Can local and/or remote push notifications mitigate the problem of battery draining background processes?
* Could you draft first the **registration process**, the creation and use of tokens, and then the flow of notifications. Explain the flow (step-by-step) and show how to setup push notification on the server?
* How and where can push notification services be attacked? Consider the security implications for developers, especially the app server with custom setup and custom logic. 
* How **Background Fetch** works with iOS compared to background tasks and compared to push notifications.

## Chapter 15 Machine Learning

* Explain the terms model, feature selection, **classifier**, training/test/validation phases
* What are the differences between supervised, unsupervised and reinforcement learning?
* Tell the differences between neuronal networks, **deep neuronal networks** and recurrent neural networks.

## Chapter 16 Selected Topics

### Search

* Why should one add items to the local Siri/Spotlight **search index**?
* How is data updated in the *today view* – in the notification center?


### Extensions

* Find some arguments, why **custom keyboard extensions** and HealthKit data are ranked critical concerning privacy and security. 

### Accessories

* Name three possibilities to extend iOS smartphone functionality with further (external) hardware? 
* Argue the specific requriements for CarKit in comparison to HomeKit or iBeacons.
* Explain steps taken by app developers to integrate external accessories (e.g. to use iBeacons)? 

### Game Center

* Can you draft an architectural overview of game center collaboration? 

### Manage Devices and Apps within Companies

* Could you name several ways for companies to secure data on the devices when allowing their employees to Bring Your Own Device (BYOD).


### AirTags 

* Explain the data flow during setup and tracking.
* Why does Apple claim to preserve your privacy while you are tracking your AirTags? 



--- 
#### [Back to the overview](./study-material--overview.md)
---
