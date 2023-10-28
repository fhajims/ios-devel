//
//  NestedListView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Navigation
//
//  Created by John on 17.10.22.
//

import SwiftUI
import CoreLocation

// We prepare some data
// cities located in Austria, with information about the Bundesland (federal state)
// E.g. city "Graz" located in Steiermark, ...
struct FederalState:Identifiable, Equatable{
    let id: UUID=UUID()
    let title:String
}
let stmk = FederalState(title: "Steiermark")
let kntn = FederalState(title: "Kärnten")
let vbg  = FederalState(title: "Vorarlberg")
let autStates: [FederalState] = [stmk,kntn,vbg]

struct City:Identifiable,Hashable{
    static func == (lhs: City, rhs: City) -> Bool {
        lhs.name == rhs.name
        && lhs.locatedIn == rhs.locatedIn
        && lhs.center.latitude == rhs.center.latitude
        && lhs.center.longitude == rhs.center.longitude
    }
    let id:UUID = UUID()
    let name:String
    let locatedIn:FederalState
    let center: CLLocationCoordinate2D
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
// we extend [City] to be filtered by "Bundesland" (federal state)
extension Array where Element == City{
    func located(in currAutState:FederalState) -> [Element]{
        self.filter { $0.locatedIn == currAutState}
    }
}
let cities: [City] = [
    City(name: "Graz", locatedIn: stmk, center: CLLocationCoordinate2D(
        latitude: 47.06667,
        longitude:  15.45) ),
    City(name: "Villach", locatedIn: kntn,center: CLLocationCoordinate2D(
        latitude: 46.61673,
        longitude:  13.85003)),
    City(name: "Wildon", locatedIn: stmk,center: CLLocationCoordinate2D(
        latitude:  46.88735,
        longitude:  15.51455)),
    City(name: "Bregenz", locatedIn: vbg,center: CLLocationCoordinate2D(
        latitude:  47.50258,
        longitude:  9.74729))
]


struct NestedListView: View {
    // A way to track what is on our navigation stack
    // Note: here only elements of type 'City' are allowed
    @State private var naviPath: [City] = []
    
    var body: some View {
        VStack{
            // The navigation stack keeps track of our current stack
            NavigationStack(path: $naviPath){
                // We group by Austrian states: Steiermark, Kärnten,...
                List(autStates) { state in
                    // E.g. section "Steiermark"
                    Section(state.title) {
                        // with cities: Graz, Bruck, Kapfenber,...
                        ForEach(cities.located(in:state)) { city in
                            // On click of a city listed
                            // we push the value, the city
                            // onto 'navigation path' stack
                            NavigationLink(city.name, value: city)
                        }
                    }
                }
                .navigationTitle("On Tour in Austria")
                // the destination is detected by (the data type (here 'City') and)
                // the top element pushed to the navigation path
                .navigationDestination(for: City.self) { city in
                    CityView(city:city)
                }
            }
            // A demo of filling a navigation stack
            // programmatically
            Button("Fast forward to three more random cities..."){
                // We jump to "somewhere",
                // by adding many cities onto the navigation stack
                for _ in 1...3 {
                    if let re = cities.randomElement(){
                        naviPath.append(re )
                    }
                }
            }
            if naviPath.count > 0 {
                Button("Home"){
                    // Empty navigation stack programmatically
                    // i.e. return home
                    naviPath.removeAll()
                }
                // We show our visits,
                // i.e. the current path (of the navigation stack)
                // O➙Graz➙Linz➙Bruck...
                Text(naviPath.reduce("O", {$0.description + "➙" + $1.name})).padding(.all)
            }
        }
    }
}

struct NestedListView_Previews: PreviewProvider {
    static var previews: some View {
        NestedListView()
    }
}
