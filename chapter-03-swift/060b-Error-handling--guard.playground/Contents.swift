import UIKit
// ensure some prerequisites are fulfilled
//          before executing the logic
//          in the body of a function
func outputScaleable(imageName img:String?){
    guard let img=img,
          img.hasSuffix(".svg") else{
        return
    }
    
    print("\(img)'.") // flower.svg
}
outputScaleable(imageName: "flower.jpg")
outputScaleable(imageName: "flower.svg")
outputScaleable(imageName: "flower.png")
