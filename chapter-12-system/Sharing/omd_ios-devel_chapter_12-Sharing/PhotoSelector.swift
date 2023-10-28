//
//  PhotoSelector.swift
//  Fruit-Detect
//
//  Created by John on 25.11.20.
//

import SwiftUI
// Check out: https://www.appcoda.com/swiftui-camera-photo-library/
// and/or:    https://www.hackingwithswift.com/books/ios-swiftui/importing-an-image-into-swiftui-using-uiimagepickercontroller


  struct PhotoSelector: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var imageLoadedFromPhotoLib: UIImage
    var sourceType: UIImagePickerController.SourceType = .photoLibrary

      func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoSelector>) -> UIImagePickerController {
        
        // Create and return an instance of UIImagePickerController
        
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

      func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<PhotoSelector>) {

    }
    
      class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: PhotoSelector

        init(_ parent: PhotoSelector) {
            self.parent = parent
        }
        
          func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.imageLoadedFromPhotoLib = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
        
    }
    
      func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}
