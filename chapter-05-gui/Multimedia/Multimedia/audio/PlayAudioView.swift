//
//  PlayAudioView.swift
//  chapter-05-gui-multimedia
//
//  Created by John on 10.07.23.
//

import SwiftUI
import AVFAudio

struct PlayAudioView: View {
    @State private var msg="Click to play"
    @State var player:AVAudioPlayer? = nil
    
    @State private var isPlaying = false
    @State private var mediaLoaded = false
    
    var body: some View {
        VStack{
            Text("Audio").font(.title)
            Button("play") {
                print("Play the audio")
                playNow()
            }
            .disabled(mediaLoaded && isPlaying)
            .padding(.all)
            Text(msg).padding(.horizontal)
        }.onAppear(){
            guard let url = Bundle.main.url(forResource: "okay", withExtension: "mp3") else {
                msg="Sorry, sound 'message for you' not found. Provide the mp3 song and try again."
                return
            }
            print("Loading mp3 \(url) into audio player...")
            if let p = try? AVAudioPlayer(contentsOf: url){
                self.player = p
                msg = "Click to play..."
                print("Player initialised.")
                mediaLoaded=true
            }else{
                msg="Sorry, Audio Player not ok. So try again."
                print(msg)
            }
        }
        .onDisappear(){
            stopPlaying()
        }
    }
    func playNow() {
        self.msg = "playing..."
        player?.play()
        isPlaying=true
    }
    func stopPlaying() {
        player?.stop()
        isPlaying=false
        msg = "Click to play..."
    }
    
}

struct PlayAudioView_Previews: PreviewProvider {
    static var previews: some View {
        PlayAudioView()
    }
}
