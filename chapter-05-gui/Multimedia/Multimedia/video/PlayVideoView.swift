//
//  PlayVideoView.swift
//  chapter-05-gui-multimedia
//
//  Created by John on 10.07.23.
//

import SwiftUI
import AVKit

struct VideoPlayerView: UIViewControllerRepresentable{
    
    let url: URL
    @Binding var isPlaying:Bool
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let pVC = AVPlayerViewController()
        pVC.player = AVPlayer(url: url)
        return pVC
    }
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        guard let p = uiViewController.player else {return}
        
        if isPlaying {
            p.play()
        } else {
            p.pause()
        }
    }
}


struct PlayVideoView: View {

    let urlString = "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8"
    
    @State private var isPlaying:Bool = false
    var body: some View {
        VStack{
            Text("Video").font(.title)
            if let u = URL(string: urlString) {
                VideoPlayerView(url: u, isPlaying: $isPlaying).onAppear(){
                    
                    isPlaying = true
                }.onDisappear(){
                    isPlaying = false
                }
            }else{
                Text("Sorry, no valid url specified. Ask your programmer...")
                    .padding(.all)
            }
        }
    }
}

struct PlayVideoView_Previews: PreviewProvider {
    static var previews: some View {
        PlayVideoView()
    }
}
