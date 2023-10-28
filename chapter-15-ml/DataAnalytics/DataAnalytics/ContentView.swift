//
//  ContentView.swift
//  omd-ios-devel-chapter-15-DataAnalytics
//
//  Created by John on 10.07.23.
//

import SwiftUI
import SwiftUICharts

struct Sales{
    let year:Int
    let quater:Int
    let euro:Double
    let cnt:Int
}

struct ContentView: View {
    let quaterlySales:[Sales] = [
        Sales(year:2033,quater:1,euro:200.01, cnt: 400),
        Sales(year:2033,quater:2,euro:230.30, cnt: 40),
        Sales(year:2033,quater:3,euro:290.00, cnt: 31),
        Sales(year:2033,quater:4,euro:120.50, cnt: 27)
    ]
    var body: some View {
        VStack {
            Text("Sales").font(.title)
            Text("Visualise your data")
            PieChartView(data: quaterlySales.map { $0.euro },
                         title: "€ (quaterly)",
                         valueSpecifier: "%.2f €")
                .padding(.all)
            /*PieChartView(data: quaterlySales.map { Double($0.cnt) },
                         title: "€ (numbers)",
                         valueSpecifier: "# %.0f")
                .padding(.all)
             */
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
