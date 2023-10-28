---

---
#### [Home](./README.md) | [Overview](./study-material--overview.md)

---




# Questions 

> "Questions open up creativity and discovery, while statements are focused on answers and closure." — Jeff Nischwitz
 

Now enjoy the following questions; questions with possible misleading, wrong, or inadequate answers.


## (1) Mobile Operating System 

Mobile operationg systems and apps differ from desktop operating systems and server systems.

### 1a Startup

> How is an Android app started?  ← The os forks app.bin or re-uses a preforked app from a pool!


* How is an app started?
	* What do you think, which steps are necessary to start an app from a user clicking an icon or a notification badge to reserving memory to loading code to startup first line of code to wait for user input.


### 1b Security

* What can be recorded by my app, if a user grants all permissions the app asks for?
	* What do you think, can the app extract
		* birthday, names of friends, last visit at the doctor,  
		* income and spending, gps location of my home, 
		* passwords and face-id signature?


### 1c App 2 App Communication

* How to send data to another app?
	* What do you think, how can your app ask (the system?) for current time and gps location? 
	* How will your app open external links?
	* What system services are necessary to paste data into your app?
	* Which protocol can an app (not) use to fetch data from a web service?
	* How can you open an app (from a text message) with a QR-code deep link. 


## (2) Mobile Hardware

Sensors, actuators, and user interaction (swipe, text input) are different to PC! 

> Touch input is disabled during a call? ← For security reasons only face-id is disabled!


### 2a Sensors

* What can you do more (on smartpones in comparison to PCs)?
	* On smartphone we can detect and store faces to identify users!
	* On a smartphone we work with fingers; we tab instead of clicking with the mouse on button!

* Is detecting steps walked (and/or how many floors you climed) hard? 
	* It is difficult to analyse and find patterns in the gyroscopic data!
	* We need GPS enabled to detect driving speed (to know we are on-the-go, we ride a bike, we are using public transfer)!

* Touch input is disabled during calling!

* Can iTags work on Android devices?
	* Apple does not pay money to Google, but you pay for others using iTags even if you do not possess one!


*Keywords:* proximity sensor, biometric chips, bluetooth low energy, A11y, TTS.
	
### 2b Sensitive Data

* Can any data recorded on an phone ever be save?
	* The health data collected on your iWatch is analysed by NSA (security services).
	* Your smartphone should not be near your keyboard, it could record your username and passwords you enter when logging in at Moodle or Online Banking. 

## (3) Apps 

The usage pattern, the data and interaction flow on mobile applications is different to desktop apps. 

> Is the list of items limited in a scroll view?  ← For performance reasons, Android puts the list items on a stack which is limited to 921.000 items!


### 3a Apps: UI + Navigation

* How is the 137th image in your slideshow presented?
	* In the 137th (XML described) view!	 
	* On swipe the 138th view is shown "over" the last (137th) one!

* How can I as blind person find a specific audio message out of ten messages I recorded yesterday?
	* Just switch on A11Y in system settings!


### 3b State (Storage, Data)

* How and where is data stored?
	* iOS uses property list files and android sqlite databases!

* How to resume app after rebooting the phone?
	* Before shutting down, snapshots (screenshot-images) of the latest screen are taken to present the last status very quickly to the users! 

* How to transfer data from one phone to another phone?
	* To share a photo Google and Apple use a custom (and propietary) Quick-Bluetooth protocol. 
	
* Is my profile (image) stored on device, in the Google/Apple cloud, or on another server?
	* It depends on the image format!

* How to access data stored by an app, when you update this app via the app store?
	* New / updated apps overwrite old and existing ones. Date must be fetched from a web service again!  


### 3c Differences Android / iOS Stores

* Can we upload malware into the app store?
	* Not with Android, humans check the source code! 


## (4) Coding (SWE, Languages)

Different requirements with SWE (Architectures, Design Patterns), Programming Languages. Differences between Android and iOS.

> Android will never switch to the Rust programming language?  ← For security reasons, Kotlin code should be compiled to Rust before execution!



### 4a Programming Languages

* Are iOS apps (optionally) coded in Rust 
	* Yes, systems app, because the must be never be broken by malware!



## (5) Cloud Services

Cloud services and mobile data storage/synchronisation with/without privacy and security.

> Can Push notifications work onboard a plane?  ← Push notifications require WLAN which is available in aeroplanes!


### 5a Push

* When and how do push notifications work?
	* For example, in a news app Apple provides special network, hardware, and software/services to allow bulk notifiation to more than 10.000 apps!
	
* How can users register (deregister) notifications?
	* On the device or with directly with Google/Apple.


### 5b Backup

* Backup does not backup all my data?
	* Your *Signal* chat will not be restored on an iphone you set up from a backup!


## (6) Fun / History

History and fun facts on a smartphone named *iPhone* (which was launched on the 29th of June 2007) and the operating system iOS. 

> iPhone commercials always show the time 9:41?  ← Yes, 9:41 has been choose to not confuse consumers with localised time such as 19:41 or 9:41 am!


### 6a Steve Jobs

* Safari reading list icon (eyeglass icon) is glass of Steve Jobs
	* ([Techradar](https://www.techradar.com/features/6-awesome-ios-easter-eggs-you-may-have-missed))

### 6b iPhone History

* iOS has always supported multitasking
	* (iOS 4, [itigic](https://itigic.com/all-versions-of-ios-for-iphone-fun-facts-and-more/?expand_article=1)) 
* In iOS 17 you still can select a wallpaper from 2007 (first iPhone) 
	* clownfish ([TechRadar](https://www.techradar.com/features/6-awesome-ios-easter-eggs-you-may-have-missed))
* All iPhone commercials will always have the time set to 9:41 a.m.
	* ([JavatPoint](https://www.javatpoint.com/interesting-facts-about-the-ios-operating-system)) 
* The InfoGear iPhone was the first to be released in 1998 by InfoGear Technology Corporation.
	* ([Wikipedia](https://en.wikipedia.org/wiki/InfoGear)) 


### 6c Apple 

* Apple Has Twice As Much Cash As The US Government
	* [Forbes, 2014](https://www.forbes.com/sites/timworstall/2014/04/13/fun-number-apple-has-twice-as-much-cash-as-the-us-government/)

--- 
#### [Back to the overview](./study-material--overview.md)
---
