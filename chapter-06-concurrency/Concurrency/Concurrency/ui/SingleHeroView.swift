//
//  SingleHeroView.swift
//  omd-ios-devel-chapter-06-Concurrency
//
//  Created by john on 09.02.22.
//




// This source will appear in the
//   omd_ios-devel.pdf book
// Included with:
//   \lstinputlisting{HERE/src/omd-ios-devel-chapter-06-iOS-Concurrency
//                            /omd-ios-devel-chapter-06-iOS-Concurrency
//                            /service/api.swift}
// START: in the pdf, we show line 50 to line 65: Task to await an async function


import SwiftUI

struct SingleHeroView: View {
    @Binding var currTab:Int
    @State private var img:UIImage?
    @State private var title = "not found on server"
    @State private var description = "--"
    @State private var infoMsg = ""
    
    @State var isLoading = true
    
    @State private var imgNo:Int = 1
    
    // force unwrap with "!",
    // because we are we 100% sure an image with this name exists in the asset catalog
    let placeholder = UIImage(named: "sorry")!
    
    var body: some View {
        VStack{
            Spacer()
            Text("\(title)").font(.title)
            Image(uiImage: self.img ?? placeholder)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.all)
            if isLoading {
                ProgressView().padding()
            }else{
                HStack{
                    Button("< Prev"){ showPrev()}
                    Spacer()
                    Text("Hero \(imgNo)")
                    Spacer()
                    Button("Next >"){ showNext()}
                }.padding(.horizontal)
            }
            Text("\(self.description)").font(.footnote).padding(.all).multilineTextAlignment(.center).foregroundColor(.accentColor)
            Spacer()
            if infoMsg != "" {
                Text(infoMsg)
            }else{
                Button("Reload"){
                    fetchHeroToUpdateTitleAndImg(heroID:imgNo)
                }
            }
        }.task { // do work in the background
            
            // synchronous code will still block some code (but not the UI)
            for idx in stride(from: 3, to: 0, by:-1){
                print("Debug: Delay... this view will appear in \(idx) sec.")
                sleep(1)
            }
            
            // ok, here we use asynchronous code with await
            //     (which will not block UI)
            while currTab == 1 {
                infoMsg = await countdown()
                print("Debug: Countdown Done")
                showNext()
            }
        }.onAppear(){
            // BAD IDEA: synchronous code will block rendering of UI
            /*
            for idx in stride(from: 7, to: 0, by:-1){
                print("Debug: Delay... this view will appear in \(idx) sec.")
                sleep(1)
            }
            */
            
            // BETTER:
            // for not blocking, better call tasks which are fast,
            //                   or start longer tasks in the background
            // e.g.: here an async task is started implicitly,
            //      by calling a functions containing an async task
            fetchHeroToUpdateTitleAndImg(heroID:1)
        }.onDisappear(){
            print("DBG: TODO stop counter")
        }
        
    }
    
    
    // an async, i.e. "deferable" function
    // (which must be called in the context of a "task")
    func countdown() async -> String {
        for idx in stride(from: 9, to: 0, by:-1){
            print("Debug: countdown \(idx)/7 sec.")
            sleep(1)
            // are we allowed to write on UI?
            self.infoMsg = idx > 5 ? "" : "Show next in \(idx)s..."
        }
        return ""
    }
    
    func showPrev(){
        self.showNext(increase: -1)
    }
    func showNext(increase i:Int = 1){
        imgNo += i; imgNo %= 8 // image 0...8
        fetchHeroToUpdateTitleAndImg(heroID:imgNo)
    }
    
    // sync function
    func fetchHeroToUpdateTitleAndImg(heroID:Int){
        // async task (started in background)
        Task {
            self.isLoading = true
            if let h:Hero = try? await fetchHero(byID: heroID){
                self.title = h.name
                self.img = h.uiimage
                self.description = h.desc ?? ""
            }
            withAnimation {
                self.isLoading = false
            }
            print("* Done. Hero \(heroID) fetched.")
        }
        print("DEBUG: fetching hero \(heroID) started in the background")
        // async Task started in the background,
        // i.e. we can return quick from normal/sync function
    }
    
    
}

struct SingleHeroView_Previews: PreviewProvider {
    @State static var currTab = 2
    static var previews: some View {
        SingleHeroView(currTab: $currTab)
    }
}
