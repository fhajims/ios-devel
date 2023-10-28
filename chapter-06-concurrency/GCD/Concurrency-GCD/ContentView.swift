//
//  ContentView.swift
//  omd-ios-devel-chapter-06-Concurrency-GCD
//
//  Created by john on 10.02.22.
//

import SwiftUI




struct ContentView: View {
    @State private var res:String = "nothing computed"
    @State private var isWorking:Bool = false
    var body: some View {
        VStack{
            
            Text("GCD")
                .padding()
            Button("Trigger a CPU intensive task", action: {
                isWorking=true
                res="working..."
                cpuIntensiveTask()
            }).disabled(isWorking)
            Text("Result: \(res)")
        }
    }


    private func cpuIntensiveTask(){
        let concurrentQueue = DispatchQueue( // custom queue
            label: "at.fhj.ims.worker",
            qos: .background,                     // very low priority
            attributes: .concurrent)             // not: one after the other

        // start 'background' work
        concurrentQueue.async {
            // calculate something (CPU-intensive work)
            // for possibly a very long time
            for cntDown in stride(from: 12, through:1,by: -1) {
                sleep(1)
                // every time we want to update the UI we have
                // to do it on the main queue!
                DispatchQueue.main.async() {
                    res="Working ... \(cntDown)"
                }
            }
            // ...
            DispatchQueue.main.async() {
                // update UI
                isWorking=false
                res = "Done"
            }
        }

    }


}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
