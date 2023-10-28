//
//  ComplexInputsView.swift
//  omd-ios-devel-chapter-05-SwiftUI-Widgets
//
//  Created by John on 18.01.22.
//

import SwiftUI

enum Sex{
    case male
    case female
    case diverse
}
struct Profile{
    var sex:Sex
    var hasSignal:Bool = true
    var birthday:Date = Date()
    var favColor:Color = .red
    
    var pretty:String {
        """
        Sex: \(self.sex)
        Birthday: \(self.birthday.formatted( .dateTime.weekday().year().month().day() ))
        Signal: \(self.hasSignal)
        """
    }
}

struct ComplexInputsView: View {
    @State private var profile:Profile = Profile(sex: .female)
    
    var body: some View {
        GroupBox(label:
                    Label("Forms and Pickers", systemImage: "profile")
        ) {
            Form{
                Section(header: Text("About Me")) {
                    Picker("Sex", selection: $profile.sex) {
                        Text("Female").tag(Sex.female)
                        Text("Diverse").tag(Sex.diverse)
                        Text("Male").tag(Sex.male)
                    }
                    DatePicker(selection: $profile.birthday,
                               displayedComponents: [.date],
                               label: { Text("Birthday") })
                    ColorPicker("Favorite Color", selection: $profile.favColor)
                }
                Section(header: Text("Messengers")) {
                    Toggle("Signal", isOn: $profile.hasSignal)
                }
                Section(header: Text("Summary")) {
                    ScrollView {
                        Text(profile.pretty)
                    }.foregroundColor(profile.favColor)
                }
            }
        }
    }
}

struct ComplexInputsView_Previews: PreviewProvider {
    static var previews: some View {
        ComplexInputsView()
        ComplexInputsView().preferredColorScheme(.dark)
    }
}
