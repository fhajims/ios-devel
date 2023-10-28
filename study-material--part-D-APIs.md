---

---
#### [Home](./README.md) | [Overview](./study-material--overview.md)

---


# Part D: APIs

> "Most of you are familiar with the virtues of a programmer. There are three, of course: laziness, impatience, and hubris." — Larry Wall
 

## Consuming Web Services

> "We are all now connected by the Internet, like neurones in a giant brain." — Stephen Hawking

* Consume ReSTful web service (ws)
* Background fetch

## De-/Serialising JSON

* Find out how to *download JSON data in the background*  in [Part C: Apps Background Task](./study-material--part-C-Apps.md).

* Specify protocol ```Codeable``` for a struct (or class) to allow JSON data to be converted into in-memory Swift objects.
	* structs can be nested
	* structs can be optional 
	* if necessary, attributes (keys) can be *renamed*, i.e. matched to other names
	* if necessary, conversions (e.g. a string or a number into `Date`) can be defined.


	  
## Notifications

> "Message for you, Sir" — Monty Python’s Holy Grail

* Local notifications
* Remote notifications (**push notifications**)
	* require Apple infrastructure, i.e. Apple Push Notification Services (APNS)	
	* See ![Push Notifications with APNS](pdf/push-notifications.pdf)
	* registration 
		* (1) fetch token from APNS, then 
		* (2) send this token to company server
	* (3) company submits notification message with known token(s) to APNS
	* (4) APNS sends notification message
* consume notifications
	* if app is active: handle in the background
	* if app is not active: add label to app 
	* update app data, i.e. fetch data from server if necessary

## Sensors

> "Intelligence is the ability to adapt to change." — Stephen Hawking

A simple near/far status ("your ear is near to the iPhone") can be obtained by the  **Proximity** sensor.

**Raw sensor data** can be requested from the  **Accelerometer** (relative device speed for x/y/z directions, gravity), **Gyroscope** (3D x/y/z location of the device), Magnetometer, ...

**Combined sensor data** is available also. For example, **Altimeter** (absolute altitude, or relative altitude and air pressure with use of a barometer), 
Higher level APIs of `CoreMotion` report further input, such as **walking**, **running**, **cycling**, **automotive**, ... with *low*, *medium*, or *high* confidence. A **pedometer** delivers information on **distance**, **floor count**, and **step count**. Furthermore the device **attitude** and **heading** can be polled.

Further sensors are Ambient Light, Bluetooth Low Energy (BTLE), ..., Fall-Detection (iWatch only), ... water **submersion**, water **temperature**.


* Usage of polling the Proximity, Barometer, Gyro, Accelerator **Sensors** is shown in the [Chapter 10 Sensors](./chapter-10-sensors/Sensors/README.md).


### Location

* Accurracy
	* IP
	* Celltower (cellular network)
	* GPS
	* WLAN
	* BT, BTLE 
* Points of Interest (POIs)
* GPS (callbacks vs. polling)
	* Longitude, Latitude and Altitude
* Geofencing
	* callback is triggered, when within range 
* Name to Lat/Long resolution (and vice versa)
	* geocoding	 
	* reverse geocoding
* Maps with
	* overlays
	* pins
	* placemarks

* Access to the location needs user consent (e.g. developers must ask for permission an provide an explanatory message for the alert)


* Usage of location data on a **Map** is shown in the [Chapter 08 Location](./chapter-08-location/Location/README.md)

### Camera

* Images, such reading QR code
* Video
* Access to the camera needs user consent (e.g. developers must ask for permission an provide an explanatory message for the alert)

## Actuators

* Vibration, force feedback
* Sound output
* Flashlight

## Networks

* HTTP
	* For *normal* network requests a secure connection `https` is required.
* Bluetooth Low Energy (BTLE)
	* Connection to other phones and devices (such as beacons) can be esablished via bluetooth.


## Sharing

* for sharing content a system requester allows to select targets
	* system apps provide sharing to, for example, mail or printers
	* installed apps (e.g. social networks) might add new targets for sharing

## Animation (2D)

> "Well, luckily with animation, fantasy is our friend" — Steven Spielberg

* General Idea: Provide **add-on value** for your users!
	* Enhance **User Experience** (UX), e.g. indicate update / loading of data
	* Guide user's **attention**, e.g. shake if user input is not accepted
	* **Communicate** information, e.g.: give context/preview when swiping from one page to another	 

* Core animation
	* **declarative**: often, we just specify (describe) which state we want to reach
	* transformation: **rotate**, **scale** (resize), **translate** (move) and possibly change color, **alpha** (transparency).
	* Optionally, set details, such as: duration, autoreverse, delay and easeIn/easeOut (-curves).
* Game loop
	* code with loop to calculate new state, trigger UI update and pause 
	* double buffering (prepare/draw in the background) for optimisation


* Usage of a few simple **2D-animations** are shown in the [Chapter 09 Animation](./chapter-09-animation/Animation/README.md). 


## Search

* Add to spotlight search index

## Optional:

### Machine Learning (ML)

> "I am in the camp that is concerned about super intelligence." — Bill Gates

* Terms: 
	* neuronal networks, deep neuronal networks, recurrent neuronal networks

	* supervised, unsupervised, reinforcement learning

* prepare data for training
	* feature selection
	* label data 
* split into training, test and validation data sets 
* train a model
* use model for classification 
	* images, text, video, motion 

### Augmented Reality (AR)

* iOS devices can detect planes and object in the environment 
* place virtual objects on planes


### HomeKit (and iBeacons), CarKit, Custom Keyboard Extensions

### Spotlight Search

* Add specific terms to the search index 
	* for users can find terms with iOS Serach (spotlight search)  and
	* navigate to (open) your app
	* navigate to specific pages within your app

### Data Exchange / Connection to watchOS Apps

* WatchConnectivity

--- 
#### [Part E: iOS](./study-material--part-E-iOS.md).

---
