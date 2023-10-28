---

---
#### [Home](../README.md) | [Overview-Mini-apps](../demo-apps.md)

---


# 6 Concurrency

Overview of Demo Projects for Chapter 6 Concurrency



**Structured Concurrency** is discussed in [study material part A Swift](../study-material--part-A-Swift.md)


### Apps (short overview)

* [Fetch](./Fetch/README.md): Simpe! Fetch **images** by URL in the background (async).
* [Concurrency](./Concurrency/README.md) Details on **async** Tasks.
* [GCD](./GCD/README.md) **Queues** for CPU intensive background work.

### Apps (details)


Decide which kind of concurrency is the right one for the job:

* Use **Timers**. For network intense jobs use [Concurrency](./Concurrency/README.md), for example, to fetch JSON data from a webservice with **async/await**. No need for callback when using **suspendable functions**. Tasks might happen on the same (even main) thread or another.

	* Use existing async functions, or create your own using the  `async` keyword:
	
		```
		func loadListOfImages() async -> [Image] { ... }
		```

	* Start *background actions* in `Task` scope and `await` the results (to be used for next action).

		```
		Task {
			let imgs = await loadListOfImages()
			let thumbs = await createThumbsFor(imgs)
		}
		```

	
* For CPU intense work use [GCD](./GCD/README.md), the  **Grand Central Dispatch** to dispatch **queues**. Set  quality of service to prioritise cpu intensive tasks and configure **explicit use of threads**. 

	* Use existing queues to perform work in the background. Set priority with quality of service `qos`: use `.userInteractive` for highest, and `background` for lowest priority.

		```
		DispatchQueue.global(qos: .utility).sync { ... }
		```

	* Move back to the main queue for **updating the UI**.

		```
		DispatchQueue.main.async { ... }
		```

## Fetch JSON data and Deserialise into objects in memory

* Fetching from web services 
	* Expect errors and invent your custom error *codes*.

	```
	enum FetchErr: Error {
   		case improperURL
   		case unexpectedResponse
	}
	``` 

	* Prepare an URL (from a string) and an URLRequest.

	```
	guard let url = URL(string: "http://...") else { throw FetchErr.improperURL}
	let request = URLRequest(url: url) 
	```

	* Load data and check response for status code
	
	```
	let (data,response) = try await URLSession.shared.data(for: request)
	guard (response as? HTTPURLResponse)?.statusCode == 200 else{
        throw FetchErr.unexpectedResponse
    }
    
    // now work with data
	```


* When fetching JSON strings with serialised data from web service endpoints, we get some raw data of type `Data` containing info such as:

	```
	[ {"title": "A new song was released."}, {"title":"Update status."}]
	``` 

* Prepare structs or classed conforming to protocol `Decodable`: 
	
	```
	struct Message: Codable{
		var title:String
	}
	```

* Decoding data into 

	```
	let decoder = JSONDecoder()
	if let messages:[Message] = try? decoder.decode([Message].self, from: data){
		for message in messages{
			print(message)
		}
	}
	``` 
	 
### Playgrounds

*  Open a very simple [async/await playground](./241-concurrency-async-await.playground).

* Open a [JSON deserialisation playground](./250-net-consuming-json.playground).


* Open a [Grand Central Dispatch (GCD) playground](./240-gcd.playground).


## Notes

For testing it might be helpful to run a very simple web service locally (e.g. just provide JSON files from the file system with a one-liner server:

* Run a [web service](./run-heros-api-webservice-locally/README.md) locally.

	```
	python3 -m http.server 
	```



---
#### Proceed to Chapter 07 [Persistency](../chapter-07-persistency/README.md) | Back to [Chapter 05 GUI](../chapter-05-gui/README.md)

---