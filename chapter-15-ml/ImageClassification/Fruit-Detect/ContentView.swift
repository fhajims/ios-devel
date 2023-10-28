//
//  ContentView.swift
//  Fruit-Detect
//
//  Created by John on 25.11.20.
//

import SwiftUI
import Vision


struct ContentView: View {
    
    // Changed values of "State" varibales are reflected on the UI
    @State var classificationMessage = "Classify this image, or\ntab on the image to select another one..."
    
    // All the images with "named:" can be found in the assets, so we force unwrap with "!"
    //   Note: A "binding variable" (here $imageToClassify) must not be Nullable
    @State var imageToClassify = UIImage(named: "Fruits")!
    
    @State private var showingImagePicker = false
    
    let fruitDetectionModel = createImageClassificationModel()
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing)  {
                Image(uiImage: imageToClassify)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .padding(.top, 0)
                Text("Tap image to select another...").padding()
            }
            Button("Classify"){
                classify()
            }
            .padding(.bottom)
            Text( "\(classificationMessage )" )
                .multilineTextAlignment(.center)
                .frame(height: 120.0)
        }.sheet(isPresented: $showingImagePicker) {
            PhotoSelector(imageLoadedFromPhotoLib: self.$imageToClassify, message: self.$classificationMessage)
        }
        .onTapGesture {
            self.showingImagePicker = true
        }
    }
    
    
    //
    // If anything goes wrong, we crash the app with "fatalError"
    //
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
    
    
    
    func classify() -> Void {
        guard let cgImgToClassify = imageToClassify.cgImage else {
            print("Sorry, no Core Graphics image available.")
            return
        }
        
        // As classification takes a while we use asynchronous calls
        // i.e. we do NOT wait for the result, but we specify a callback function
        // The callback function — called completion handler — is envoked when the classification is finished
        let classificationRequest =
        VNCoreMLRequest(model: fruitDetectionModel,
                        completionHandler: showClassificationsResults)
        

        // Simulator
        //   workaround for Classification in the
        //   otherwise error (in function showClassificationsResults):
        //   Sorry, we are unable to classify the image:
        //        Could not create inference context
        #if targetEnvironment(simulator)
                classificationRequest.usesCPUOnly = true
        #endif


        // A handler to process image classification requests
        // Here, a vision requests for a single image
        let handler = VNImageRequestHandler(cgImage: cgImgToClassify)
        
        classificationMessage = "Running classifications..."
        // Classification takes a while
        // we MUST NOT block the UI,
        // so execute the task in a background queue (background thread)
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                // Performing a list of classification requests
                // OK, or list is short with just one enty
                try handler.perform( [classificationRequest] )
            }catch {
                print("Sorry, we are unable to perform classification." +
                      "Error: \(error.localizedDescription)")
            }
        }
    }
    
    // The callback, the "completion handler"
    //     when the classification produced some results
    func showClassificationsResults(for request:VNRequest, _ error:Error?){
        // the classification run on some background queues (for not blocking the UI)
        // To update the UI, we move back to the main queue (main thread)
        DispatchQueue.main.async {
            guard let results = request.results as? [VNClassificationObservation] else {
                classificationMessage = "Sorry," +
                " we are unable to classify the image." +
                " Error: \(error?.localizedDescription ?? ".")"
                return
            }
            
            // Build a multiline string to show the result as "Apple 65%, Banana 29% ... "
            classificationMessage = ""
            for classification in results {
                classificationMessage += "\(classification.identifier) "
                classificationMessage += "\( round(classification.confidence * 1000)/10)%\n"
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
