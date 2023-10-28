---

---
#### [Home](./README.md) | [Overview](./study-material--overview.md)

---



# Part F: Security Attacks and Mitigations.


> "We must plan for freedom, and not only for security, if for no other reason than that only freedom can make security secure." — Karl Popper

## What to protect

* Your assets
	* contacts (AddessBook)
	* photos (camera, PhotoAlbum)
	* events (calendar)
	* credentials (keystore)


## Secure Code

> "Beware of bugs in the above code; I have only proved it correct, not tried it." — Donald E. Knuth


* language features
	* Type checks with `if let` 
	* Exit early with `guard` 
	* Structured error handling with `try`
		* e.g. `try? await` with async code 
	* Optionals and nullability checks: `?.` 

* testing
	* unit tests
	* UI tests 

## iOS Security

The security relys on the iOS operating system (sandbox, signing, ipc,..) as discussed in [Part E: iOS](./study-material--part-E-iOS.md).

### Selected Operating System Features

* Selected reatures: secure bootloader (iBoot), SIP (System Integrity Protection, i.e. read only file system layer for the os), kASLR (Kernel Adress Space Layout Randomization), execute never (memory pages)
* Selected restrictions for apps: JIT in WebViews, no download code execution



### Permission 

Many permissions are granted after **user consent** for a time frame given (once, during app use, forever).

* runtime permissions (not: install time permissions)
	* permissions are granted when they are used 
	* permissions can be revoked by users any time later (via system settings)

* Special `entitlements` files contain information about permission granted to use **capabilities**, such as (cloud) services (siri, push notifications, keychain sharing), sensors (NFC, HealthIKit, HomeKit) and much more. 

### Signing

* Apps have to be signed by an developer to run on real devices.
	* The Xcode IDE handle the signing, but the command line tool `codesign` can be used also.

* For development with Xcode and deployment just to the **simulator** no (registration with Apple and) developer certificates are necessary. 

* During **Testing**, apps (with unique bundle id) can be started on dedicated (device ids registered to Apple) devices. 
	* Therefore a **development certificate**, the unique **bundle id**, and multiple **device ids** are combined to a provisioning profile, here a **development profile**. This development profile has to be installed on devices to run the (beta) apps during the test phase.

* For uploading apps into the **App store**
	* A **unique bundle identifier** for the app must be registered with Apple.
	* Developers must be registered by Apple (pay a yearly fee of about 100€).
	* Developers sign the app with their personal certificate and provide a provisioning profile, here a **deployment profile**.
  


### Secure Enclave 

* secure enclave hardware provides certificates provided by the manufacturer (Apple)
* certificates are used for secure boot (chain) 
* cryptographic operations can be done be the secure enclave
* stores crypto-keys, biometric info etc
* isolated channel with CPU (for communication)

### Keystore

* data can be stored stronly encrypted in the keychain

### Biometric Authentication

* Face ID, Touch ID
* the biometric profiles (mathematical representation of face or fingerprint) are stored within the secure enclave and cannot be extracted any point later
* a fingerprint or an image of the face can be send to the secure enclave to be checkt if valid or not

### Special Cases

* For **custom keyboard extensions** the certification process by Apple is rather strict:

	* One can intercept every data entered

* AirTags
	
	* **Find me** for special made hardware (BTLE devices)

* App-specific VPN	
	
	* VPN can be set up per app

## Attacks (and Mitigation)

### Man-in-the-Middle (mitm)

* intercept traffic
* (possibly) prevent with 
	* client certificates

	
## Reverse Engineering

Inspect apps to find out, for example: the developer, the supported languages, target platforms, libraries and apis used, permission/entitlements, strings (URLs, api-keys, passwords), ...

* Inspect an app
	* Use `unzip <app.ipa>` to view the files of an `*.ipa` file 
	* Check out the developer (who signed the app) with `codesign -vd <app.app>` 
	* Find out if multiple architectures are combined in a given binary: `lipo -info <app-binary>` and extract a specific binary `lipo -thin armv7 <app-binary>`
		* Further inspection on the extracted binary (e.g. `*.armv7`)
			* List supported cpu type `otool -h <app-binary.armv7>`
			* If the app is encrypted can be detected with e.g. `lipo -info <app-binary.armv7>`
			* Search for interesting text with `strings <app-binary.armv7>`
		* Startup and **debug** with `lldb <app-binary.armv7>` (typical/useful low-level debugger commands: `help`, `exit`, `l <line-number>`, ...)

## Forensics

Inspect artefacts produced by the app. Typically, we are interessted in data created and stored about, for example, user behaviour, user input, sensor data.

* Inspect property list files (`*.plist`) 
	* Convert binary to human-readable xml with `plutil -convert xml1 <binary.plist>`

* Inspect data in relational (sqlite) databases
	* command line tool `sqlite3 <db.sqlitedb>`
	* (typical/useful sqlite commands: `.help`, `.schema <table>`, `select * from <table>;`, ...)

--- 
#### [Fun Facts](./study-material--part-Y-Fun-facts.md).
---
