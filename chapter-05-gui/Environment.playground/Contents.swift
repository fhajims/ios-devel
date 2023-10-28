import UIKit
import PlaygroundSupport

var greeting = """
    We set up a view and inject in our environment custom values using EnvironmentKey, i.e. key value coding.
"""

import SwiftUI

// just a struct to insert objects into a collection later
struct Product{
    let title:String
    let id:UUID = UUID()
}
var ps = [Product(title: "First")]
for idx in ( 1...9 ) {
    ps.append(Product(title:"Sunset-\(idx)"))
}

// *****
// EnvironmentKey and Values: START
// *****
struct ItemsPerPageKey: EnvironmentKey {
    static var defaultValue: Int = 10
}

extension EnvironmentValues {
    var itemsPerPage: Int {
        get { self[ItemsPerPageKey.self] }
        set { self[ItemsPerPageKey.self] = newValue }
    }
}
// *****
// EnvironmentKey and Values: END
// *****



struct RelatedProductsView: View {
    // fill the variable count
    // with values from the (injected) environment
    @Environment(\.itemsPerPage) var count
    
    let products: [Product]
    
    var body: some View {
        let c = min(count, products.count)
        ForEach(products[..<c], id: \.id) { product in
            Text(product.title)
        }
    }
}


// USAGE:
let v = RelatedProductsView(products: ps)
            // fill into the environment the variable count
            // to be used later within the view
            .environment(\.itemsPerPage, 17)


// Present the view controller in the Live View window
PlaygroundPage.current.setLiveView( v )
    
