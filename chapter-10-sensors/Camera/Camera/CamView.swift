
import SwiftUI

// We need the UIImagePickerController
// from UIKit (included in SwiftUI ?!)


// Note the protocol "UIViewControllerRepresentable"
//                  makeUIViewController
//                  updateUIViewController
//                  makeCoordinator


// ...Use a UIViewControllerRepresentable instance to create and manage a UIViewController object in your SwiftUI interface....
// ...When you want your view controller to coordinate with other SwiftUI views, you must provide a Coordinator instance ....
struct CamView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage
    @State var fromSourceType: UIImagePickerController.SourceType
    @Environment(\.presentationMode) private var presentationMode
    
    
    // Create (and configure) a view controller (object)
    func makeUIViewController(context: UIViewControllerRepresentableContext<CamView>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = fromSourceType
        imagePicker.cameraDevice = .rear
        imagePicker.showsCameraControls = true // show take image, cancel, ... buttons
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    
    // Update the inner state of a view controller (object)
    // ... = update with new infos from SwiftUI, ie. after user interaction...
    // her: nothing to do
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CamView>) {
        // nothing to update
    }
    
    
    // We provide a custom coordinator object
    // to communicate changes (from view controller to SwiftUI)
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: CamView
        
        init(_ parent: CamView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

