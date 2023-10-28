---

---
#### [Home](./README.md) | [Overview](./study-material--overview.md)

---



# Part C: Apps


> "Every child is an artist. The problem is how to remain an artist once he grows up." — Pablo Picasso


**Motivation:** How can I create a flexible (scrolling, center) nested layout (spacer, v/h/z-stacks, padding) with built-in (map, image, symbol) and custom reuseable components (lightweight views as `structs`) for a beautiful ui (color, fonts)? How to design interaction and allow to navigate (tab, swipe, show details, overlay) from one view to another?


## Structure (Files and Folders)

App are bundled into **ipa** files which contain among others:

* Info.plist 
	* defining permissions
	* store configuration values (instead of hard-coded values within your app)
* Assets (files in a directory, e.g. `Assets.xcassets`)
	* images (app icon) in multiple resolutions
	* spedifying the deployment target (e.g. iOS version `23.9`) 
* **Localization** (`*.strings`) files  
	* translations to different languages
* (fat) binaries
	* for multiple platforms / hardware architecture	
* Certificates 
	* signature of the developer 
* Entitlements
	* specify permissions to use a service
		* e.g.: Games, Health, iCloud, Push Notifications, Siri    

## Life-cycle

* The app starts by *executing* code (the code defined by a `struct` conforming to the protocol `App`) annotated with ```@main```.
	* Example

		```swift
		@main
		struct SlideshowApp: App {    
		    var body: some Scene {
		        WindowGroup {
		            SlideshowView()
		        }
		    }
		}
		``` 
	Note, the app provides a property `body` (of type `Scene`) which represents the user interface to be shown.

* Callbacks
	* block of code prepared to be executed on an event. For example, code exectued when another app comes to the foreground, or a code to stop polling a sensor for location data.

	
* For App start, put code into constructor
	* ```init()``` 	

* For the App, react on change of *Scene State*:
	* ```active```
	* ```inactive```
	* ```background```
	* To get the current state, declare an environment ```@Environment(\.scenePhase)``` variable, which gets updated by the system automatically

* For a View, react on *appear*:
	* ```onAppear```
	* ```onDisappear```


## UI User Interface

* SwiftUI
	* Define UI the same way for watchOS, iOS, macOS, tvOS
	* **Declarative** code

	
		```swift
		struct ContentView: View {
		    var body: some View {
		        VStack{
		          Text("Flowers")
		          Image(uiImage: image)
		          Button("Classify"){
		          	classifyImage()
		          }
		          ...
		      	}
		    }
		}
		```
	
	
	* Design in Code (optionally preview/edit on canvas)
	* Views 
		* are lighweight (just structs) `struct DetailsView: View { ...` with a body of nested views `var body: some View {...`.
		* are recreated (and destroyed) often
	* A `Scene` manages a tree of views.
	* Architectural Pattern:
		* Mode-View-ViewModel MVVM
			* instead of Mode-View-Controller MVC
			* View -> ViewModel -> Model
			* (Two-way) Databinding: Model <-> View



### Localisation (L10n) / Internationalisation (I18n)

* Every (static) string in the code is localised automatically, if translation files are available. Translations are provided as key value in `Localizable.strings` files for each language in the file system.

	* file `de.lproj/Localizable.strings`:

		```
		"work" = "Arbeit";
		```

	* file `en.lproj/Localizable.strings`:

		```
		"work" = "work";
		```

* Usage of **Internationalisation (I18n)**, i.e. using multiple languages on the user interface with **Localisation (L10n)** is shown in the [Chapter 05 GUI / Localisation](./chapter-05-gui/Localisation/README.md)



### Accessibility (A11y)

* define for UI elements (e.g. for blind persons):
	* label (short title)
	* hint (long explanation)
	* value (current state)
	* action (ways to change the value)
	* traits (e.g. this is just static text, or this is a slider)

		```swift
		Slider(value: $selection)
		    .accessibilityHint("Select your favorite number by sliding to the left")
		    .accessibilityValue("\(selection)")
		    .accessibilityAddTraits(.allowsDirectInteraction)
		    .accessibilityIdentifier("favNumberSlider")
		```

* Usage of setting **Accessibility hint** (traits) is shown in the [Chapter 05 GUI / Accessibility](./chapter-05-gui/Accessibility/README.md)


### Preserve State / Storages

Developers can persist (user) data into key value stores, into a secured keystore, into a relational database, and into cloud databases.


* Key-values store (and the shortcut `@AppStorage`) 
	
	```swift
	@AppStorage("theme") var theme: String = "dark"
	```

* Sensitive user data can be stored into a encrypted secured keystore.

* Database called `CoreData` including O/R-Mapping

	* With CoreData the relational data model is created first. Then Xcode uses code generation to produce the classes accordingly.
	* A bit of boilerplate code is necessary to manage the specialised swift objects. One will work with so called `Managed Object`s and `Persistent Container`s.
	
	
* Cloud databases / cloud synchronisation





 


### Delegation (instead of inheritance)

* The concept of delegating work to another instance 
	* often used instead of providing functionality class-internally with inheritance 

### Background Task

Keep the user interface responsive. Never blocking execution by calling long-lasting calls (such as method calls to access the network / database / filesystem). Execute CPU heavy and/or long-lasting calls in the background:

**Structured Concurrency** is discussed in [study material part A Swift](./study-material--part-A-Swift.md)

* Use **async/await** for **concurrency**
	* provide a *special* environment `Task{...}` within one might `wait` for the results provided by long-lasting functions. The long-lasting functions are anotated as `async`, which means they can be suspended and continued later. 
	* optimised by compiler (and runtime)

		```swift
		Task {
	      let listOfSlides = try? await self.fetchListOfSlidesFromWebService()
	      ...
		```
		
		```swift
		func fetchListOfSlidesFromWebService() async throws -> [Slide] {
        	...
        	let (data, response) = try await URLSession.shared.data(for: wsRequest)
        	...
		```

	* Find out how to *deserialse downloaded JSON data* into structs/objects in [Part D: APIs De-/Serialising JSON](./study-material--part-D-APIs.md).

* Grand Central Dispatch (**GCD**)
	* for full control of thread creation (if needed)
	* supports priorities for queus
	* set *quality of service* to define
		* priorities (e.g. *background* or *user initiated*)

		```swift
		let concurrentQueue = DispatchQueue( 
		    label: "at.fhj.ims.worker",
		    qos: .background, 				
		    attributes: .concurrent) 
    	... 
		concurrentQueue.async {
			 // intense calculation 
			 ... 
		    DispatchQueue.main.async() { 
		    	// update UI with results
		    	...
		    }
		}
		```

### Data Binding 

#### Two way data binding in SwiftUI.

By annotating vaiables (with so called *Property Wrappers*):

* ```@State``` to **autmatically update UI** on change
	* *Note: works with any ```struct``` (but does not work for class objects. Use ```StateObject``` as explained below)*
	* pass as reference (with ```$``` variables) to other views
	* Examples

		```swift
		struct Slide: View {
			@State private var isVisible = true
			@State private var isFavorite = true
			
			var body: some View {
				VStack{
					// using the value
					if isVisible == true {
						SlideDetailView(isFavorite: $isFavorite)
					}
					
					// changing the value
					Toggle("Show this slide", isOn: $isVisible)
				}
			}
		}
		```


* ```@Binding``` to use **variables of other views** 
	* use data of views which own the *source of truth*
	* a view get a reference/variable passed in (on creation) 
	* Example of current view using data passed in from the parent view (variables annotated with @State in the parent view)  
	
		```swift
		struct SlideDetailView: View {
			@Binding var isFavorite: Bool
			
			var body: some View {
				Button(action: {
	            self.isFavorite.toggle()
	       	}) {
	            Text(isFavorite: "*" ? "-")
			}
		}
		```  



* ```@StateObject``` to create **observed objects**
	* *Note: only used with class objects conforming to protocol ```ObservableObject``` (for data binding to model using ObservableObject see below)*
	* create observed objects distinct to a view instance
	* objects where the inner state is preserved
	* i.e. objects which are *NOT* recreated every time the view is initialised
	* Example

		```swift
		struct SlideshowView: View {
 		   @StateObject var keySlide = Slide()
    
			var body: some View {
        		SlideView(slide: keySlide)
    		}
		}
		```
	

#### Two way data binding to model

Automatically update views, when data in the background changes (i.e. ```observed objects``` change their internal data).

* ```@Published``` to mark model **data observable**
	* Examples

		```swift
		class Slide: ObservableObject {
    		@Published var title = "Sunrise"
    		let identifier = UUID() 
		}
		```
		
* ```@ObservedObject``` to **monitor changes**
	* Example 

		```swift
		struct SlideShowDetailView: View {
 		   @ObservedObject var slide: Slide
    
    		var body: some View {
        		// read:
        		// Text(slide.title)
        		
        		// write:
        		TextField("Title", text: $slide.title)
    		}
		}
		```

### Create and access environment data

For data model objects you need throughout an app (kind of *global* data).

* Create single instance within the app and pass this instance within the *Environment* of view hierarchies. 
	* Example 

		```swift
		@main
		struct SlideshowApp: App {
    		@StateObject var slides = Slides()
    
		    var body: some Scene {
		        WindowGroup {
		            SlideshowView()
		                .environmentObject(slides)
		        }
		    }
		}
		```
		
* ```@EnvironmentObject``` to use the *global* data
	* Examples

		```swift
		struct SlideshowView: View {
    		@EnvironmentObject var slides: Slides
    		// ...
		}
		``` 

* ```@Environment(.\<key>)``` to access the environemt of a View (using a key such as ```\.locale``` and ```\.TimeZone```, ```\.accessibilityEnabled```, ```\.managedObjectContext```,  ```\.pixelLength``` and ```\.displayScale```, ```\.editMode``` and  ```\.isFocused```, ```.\scenePhase```, ```.\openURL```)
	* Examples: 
		
		```swift
		@Environment(\.presentationMode) var presentationMode
		@Environment(\.colorScheme) var colorScheme: ColorScheme
		@Environment(\.locale) var locale: Locale
		```
		
		Lookup Apple documentation for a [list of keys](https://developer.apple.com/documentation/swiftui/environmentvalues).
		
* Usage of creating you own **custom environment keys** and put some other objects into the environement is shown in the [Chapter 05 Environment](./chapter-05-gui/Environment.playground) playground. 


### Navigation

* Simple navigation can be implemented with `TabView`s.

* Custom navigation to (any) another view using a `NavigationLink`
	* by instantiating another view
	* and replacing (parts of the) content (of the current view) on the UI. Replace everything within `NavigationView`.  
	* use ```dismiss``` to close current view and return.

	For example, a master detail view is set up with:
	
	```swift
	var body: some View {
	  NavigationView {
	    //..
       NavigationLink( destination: DetailsView() ) {
         Text("Navigate to the details")
       }
       //..
    }
	```

* Overlays can be *presented* using the `.sheet( isPresented: ..)` methods.

* Advanced navigation for (long) lists holding the same data types can be achieved with a `NavigationStack`. 

* Normally, links to trigger the navigating back (by popping a view from the stack) is provided automatically by the system.  Dismissing programmatically, is done using a function `dismiss` provided in the environment:

	```swift
	@Environment(\.dismiss) var dismiss
	...
		self.dismiss()
	```

* Navigate to other Apps
	* use method ```openURL``` of ```UIApplication.shared```.

--- 
#### [Part D: APIs](./study-material--part-D-APIs.md).

---