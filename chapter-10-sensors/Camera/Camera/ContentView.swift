//
//  ContentView.swift
//  omd-ios-devel-chapter-10-Camera
//
//  Created by John on 08.11.22.
//
// Request for Camera Usage,
//    First select in the Menu: View/Navigators/Project
//         then select the current project (top level),
//         then select "Targets", left click on "10 Camera"
//         then check out tab "Info"
//    ie. for the (automatically generated) Info.plist we add:
//      Privacy - Camera Usage Description
//      (i.e. key =  "NSCameraUsageDescription")
//      with text (value) such as
//      "Allow camera usage to change the background of your app"

// Hint: check out Apple Sample Code:
//  "Building a Camera App"
// https://developer.apple.com/documentation/avfoundation/capture_setup/avcam_building_a_camera_app

// UIImagePickerController - Notes:
//   ONLY PORTRAIT mode supported !

import SwiftUI

struct ContentView: View {
    @State private var img:UIImage =
    UIImage(imageLiteralResourceName: "default")
    @State private var showCam = false
    var body: some View {
        VStack {
            Image(uiImage: img)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .imageScale(.large)
                .foregroundColor(.accentColor).onTapGesture {
                    print("DEBUG: you tapped, so we change the image")
                    showCam = true
                }
        }
        .padding()
        .onAppear(){
            print("We show the default image \(img)")
        }.sheet(isPresented: $showCam) {
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                CamView(selectedImage: $img, fromSourceType: .camera)
            } else {
                CamView(selectedImage: $img, fromSourceType: .photoLibrary)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

