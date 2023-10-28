---

---
#### [Home](./README.md) | [Overview](./study-material--overview.md)

---



# Part E: iOS Operating System


> "But they are useless. They can only give you answers."
— Pablo Picasso on calculating machines



## Install & Execute Apps

### Sandboxes

* entitlements
	* define the required (additional) permissions of apps 
	* are necessary for specific (cloud) services 

### Signing

* certificates
	* every app must be signed by a developer. 
	* To become developer one needs an Apple ID, i.e. developers need (free or paid) registration with Apple
	* for development: developers need no registration when testing on the simulator
	* for development: developers need an  with free registration with Apple to deploy apps for testing on real devices
	* for distribution: only apps signed by developers with paid registration can be installed on a device


### Exectables (within IPAs)

* executable might include the compiled binaries for multiple platforms. Such executables are called **fat binaries**.


## Inter-process Communicatin (IPC)

Heavily restriced due to the iOS Sandboxing for Apps.

* Clipboard

* URL Schemes / Sharing
	* call system apps
	* call other apps 
	* Websites can provide **Universal links** to allow (installing and) opening apps on a device. 

* Network stack

* Mach Port
	* low-level only 
	* queue of messages

* File system 
	* Note: **app groups** (application groups are apps signed with the same developer certificate) required
	* For example *shared preferences* and *shared keychain items* are supported with app groups.

* not possible with iOS, i.e. macOS only
	* Signals
	* Unix domain sockets 
	* kernel queues
	* shared memory
	* stream
	* pipes, named pipes

* Notifications
	* local notifications
	* push (remote) notifications 


## Compare to Android

| Topic         | iOS             | Android              |
|:------------- |:---------------:| :------------------- |
| IPC           | URL-Schemes, ...| Binder, ...          |
| Security      | Sandboxing, ... | SE-Linux, ...        |
| Memory Mgmt   | LLVM, ARC, ...  | ART (JIT, AOT), ...  |

--- 
#### [Part F: Security (Attacks and Mitigations)](./study-material--part-F-Security.md).
---
