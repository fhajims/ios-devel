//
//  Helpers.swift
//  omd-ios-devel-chapter-06-Concurrency
//
//  Created by John on 29.10.21.
//

import Foundation
import UIKit

// This source will appear in the
//   omd_ios-devel.pdf book
// Included with:
//   \lstinputlisting{HERE/src/omd-ios-devel-chapter-06-iOS-Concurrency
//                            /omd-ios-devel-chapter-06-iOS-Concurrency
//                            /Helpers.swift}
// 2021, jf
// START: in the pdf, we show line 20 to line 30: async property for existing class UIImage

extension UIImage {
    var thumb: UIImage? {
        get async {
            let size = CGSize(width: 45, height: 45)
            return await self.byPreparingThumbnail(ofSize: size)
        }
    }
}



// END:   in the pdf, we show line 20 to line 30: async property for existing class UIImage
