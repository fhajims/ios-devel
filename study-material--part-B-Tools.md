---

---
#### [Home](./README.md) | [Overview](./study-material--overview.md)

---


# Part B: Tools

> "The technology you use impresses no one. The experience you
create with it is everything." — Sean Gerety


## Development Environment

### The macOS keyboard

Remember following keystrokes, because certain keys are not marked at the keyboard. 

| **I want**            | **I press keys**         | **Result**                |
|:-------------         | :---------------  | :------------------------- |
| \                     | OPTION-SHIF-7     | a backslash `\`      |
| {                     | OPTION-8          | curly brackets `{`   |
| }                     | OPTION-9          | curly bracket`}`     |
| [                     | OPTION-5          | square brackets `[`  |
| ]                     | OPTION-6          | square brackets `]`  |
| ~                     | OPTION-N          | a tilde `~`          |
| \|                    | OPTION-7          | a pipe `|`          |

*Note: be aware of the location of the @ sign. It is `ALT-L` (not `CMD-Q` which quits the current app).*


### Fast navigation within macOS


Open Application or Settings quickly using **Search**: 

| **I want**            | **I press keys**         | **For quick result**                |
|:-------------         | :---------------  | :------------------------- |
| Open an application   | CMD-SPACE         | Type first letters such as `Fir` for Firefox, `Fin`  for Finder, `X` for Xcode,  `S`  for Safari. To confirm your select ion press return/enter key |

View **hidden** files in Finder:

| **I want**               | **Press**         | **Result**                   |
|:-------------            | :---------------  | :---------------------------- |
| Show/Hide hidden Files   | CMD-SHIFT-.       | for example `.ssh` directory is shown |



## Develop
	
### LLVM Compiler Infrastructure

Xcode uses the LLVM to compile source code. You might run the commands on the terminal also.

* Advantage of LLVM (e.g. over gcc)
	* Optimisation in **intermediate representation** (independent of programming language)

	* Frontend: process source to IR
		* For C: clang compiler
		* Details for Swift compilation flow:
			* parse source to Abstract Syntax Tree (AST)
			* semantic alalysis
			* Swift Intermediat Language (SIL) generation
			* SIL optimizations, transformation to LLVM IR
			* Try, e.g. `swiftc --emit-ir <slide.swift>`
	* Optimiser: optimises  the LLVM IR
	* Backend: output to x86, ARM, bytecode (JVM), ...

*Note: LLVM was formerly used as abbreviation for Low Level Virtual Machine*

### Xcode



* [Xcode.app](/Applications/Xcode.app) is the Integrated Development Environment (IDE) of choice by Apple 
* Features
	* git integration 
	* live preview of UIs, including live navigation

* Table of most useful keyboard shortcuts

| I want                | I press             | Result |
|:-------------         | :---------------  | :------------- |
| Reformatted source    | CMD-A then CTRL-I | Select all code lines and format indentation |
| Will it compile?      | CMD-B             | Compilation starts and presents errors if any |
| Run again             | CMD-R             | Run the app on simulator or on a connected real device |

#### Xcode Projects, Workspaces and Playgrounds

* projects: Create your iOS app by starting a **new project**.
* workspaces: Multiple projects can be combinded to a workspace. *Historical note: workspaces were necessary for the Cocoapod package manager, before the Swift package manager was introduced.*
* playground: Learn coding in Swift. Try out things. Your small sandbox to play around.

* Better configure your `.gitignore` file to NOT add temporary or user-related files. Compare this [.gitignore](.gitignore) and ingnore in your projects for example: `xcuerdata/`, `tmp`, or `*.DS_Store`.


### Simulator

The simulator is a desktop application, that provides the same APIs as a smartphone. The simulator does **not emulate a real device**.


## From Source to App

Xcode automates the steps necessary to deploy an app to the simulator and devices.

* An Xcode *Scheme* specifies the tasks executed to build, run, test, profile, analyse, and archive.
	* The build phase typically includes: **compiling** the sources (`*.swift` files), **linking** the binary and **copying** resources (assets) for the app bundle.  


## Test


> "I have not failed. I've just found 10,000 ways that
won't work." — Thomas Edison


* Unit tests 
	* check the expected results of function and method calls
	* can be used to measure time (performance)
	* are created and exectuted within Xcode as an additional target within an app project. 

* UI tests
	* prerequisites 
		* UI elements are accessibly for remote control only when accessibility IDs are assigned. I.e. the unique identifier `.accessibilityIdentifier` must be set. This id is used to read or manipulate elements onscreen during test automation. 

			```swift
			Slider(value: $selection)
			    .accessibilityIdentifier("favNumberSlider")
			```
	
	* UI tests are created and exectuted within Xcode as an additional target within an app project. 
	* they are executed by remote controlling the simulator 

		```swift
		func testTheSliders() throws {
			let slider = app.sliders["favNumberSlider"]
			slider.swipeRight()
			if let selectedVal = slider.value as? String{
				XCTAssertEqual(selectedVal, "0.8")
		```

## A Tool for Machine Learning

Xcode might run machine learning tasks such as classification locally on the device. First, models must be created with the developer tool [Create ML.app](/Applications/Xcode.app/Contents/Applications/Create\ ML.app) and trained with large data sets (often with hundreds of megabytes of data). After testing the (very small sized, a few kB) models are exported into the file system. Then, using Xcode the models can be imported and used within your projects.  


## Performance

Finding memory leaks and checking performance is done with the developer tool [Instruments.app](/Applications/Xcode.app/Contents/Applications/Instruments.app/).

## Package

Packaging is done within Xcode via the so called *archive* - action. The generated `*.ipa` bundle is uploaded to the App Store for testing and distribution. See App Store below.

## Signing & Deployment

Every app (even for testing on your own device) **must be signed** by a registed Apple developer.

## Beta Testing

Beta testing can be done internally with members of the development team. It can be done externally with other test users. Both approches need the **Test Flight** application installed on the test devices.

## App Store

To distribute an app via the **Apple App Store** requires a yearly fee of about 100€.

--- 
#### [Part C: Apps](./study-material--part-C-Apps.md).
---
