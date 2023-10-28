//
//  PhotoSharing.swift
//  omd_ios-devel_chapter_12-Sharing
//
//  Created by John on 05.01.21.
//

import SwiftUI

struct PhotoSharingView: View {
    
    @State var shareThisImage:UIImage = UIImage(systemName: "plus.circle.fill")!
    
    @State private var showingImagePicker = false
    
    @State private var isShareImagePresented = false
    
    var body: some View {
        VStack{
            Spacer(minLength: 120)
            Text("Photo")
                .font(.title)
                .fontWeight(.black)
                .padding(.top)
            Spacer()
            ZStack{
                GeometryReader { geometry in
                    Image(uiImage: shareThisImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                        .foregroundColor(.red)
                        .frame(width: geometry.size.width*0.85,
                               height: geometry.size.width*0.85,
                               alignment: .center)
                        .padding()
                        .onTapGesture {
                            print("Thx, you tapped on image...")
                            self.showingImagePicker = true
                        }
                        .sheet(isPresented: $showingImagePicker ) {
                            PhotoSelector(imageLoadedFromPhotoLib: self.$shareThisImage)
                            
                        }
                }
                .background(Color(.gray).shadow(radius: 7))
                Button("Tap for sharing this image"){
                    print("TODO: implement photo sharing")
                    self.isShareImagePresented = true
                }
                .padding(.top, 366.0)
                .foregroundColor(.white)
            }
            Spacer(minLength: 120)
            
        }
        .sheet(isPresented: $isShareImagePresented,
                onDismiss: {
            print("Dismissing the share activity sheet...")
        },
                content: {
            CustomShareActivityViewController(
                prepareActivityItems: [shareThisImage])
        })
    }
}
struct PhotoSharingView_MyPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            PhotoSharingView()
        }
    }
}
