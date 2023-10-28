---

---
#### [Home](../../README.md) | [Up](../README.md) | [Overview-Mini-apps](../../demo-apps.md)

---






## Image Classification

In Demo Projects for Chapter 15 Machine Learning (ML).

![](screenshots/15-MachineLearning-AppIcon.png)
![](screenshots/15-MachineLearning.png)

Create a model with **Create ML** App and export the model `HelpfulFruitClassifier`. Add the model `HelpfulFruitClassifier` to your Xcode project. 

Provide functionality to load and use your model with the Filename `HelpfulFruitClassifier`. 

```swift
static func createImageClassificationModel() -> VNCoreMLModel {
        let defaultCfg = MLModelConfiguration()
        
        guard let imgClassifierWrapper = try? HelpfulFruitClassifier(configuration: defaultCfg) else {
            fatalError("Sorry, we could not create an instance of our image classifier.")
        }
        let imgClassifier = imgClassifierWrapper.model
        
        guard let fruitDetectionModel = try? VNCoreMLModel(for: imgClassifier) else {
            fatalError("Sorry, we could not create an instance of Vison Core Machine Learning Model.")
        }
        
        return fruitDetectionModel
    }
```


Prepare a **Classification Request**. Note it is necessary to prepare a callback function (called a *completionHandler*, see for the completion handler `showClassificationsResults ` further down on this page):

```swift
let classificationRequest =
        VNCoreMLRequest(model: fruitDetectionModel,
                        completionHandler: showClassificationsResults)
```


Create a handler with your image to classify

```swift
let handler = VNImageRequestHandler(cgImage: cgImgToClassify)
```

Now start the classification task (in the background)

```swift
try handler.perform( [classificationRequest] )
```


When the classification produced results, the callback function (called **completion handler**) extracts the results to update the UI:

```swift
func showClassificationsResults(for request:VNRequest, _ error:Error?){
  // ...
  guard let results = request.results as? [VNClassificationObservation] 
  // ... 
  for classification in results {
                classificationMessage += "\(classification.identifier) "
                classificationMessage += "\( round(classification.confidence * 1000)/10)%\n"
  }
  // ... 
}
```



[Open the project](./Fruit-Detect.xcodeproj).
	
---
#### Back to [Chapter 12 System (Services)](../../chapter-12-system/README.md)

---