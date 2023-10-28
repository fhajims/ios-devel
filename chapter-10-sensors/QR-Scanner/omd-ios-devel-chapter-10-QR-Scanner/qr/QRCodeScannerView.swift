//
//  QRCodeScannerView.swift
//  omd-ios-devel-chapter-10-QR-Scanner
//
//  Created by John on 26.11.21.
//

import SwiftUI


// Add package
// 1.) download from
//     https://github.com/twostraws/CodeScanner
//     git clone ...
// 2.) add package
//     Menu File Add Packages / Add local
//     Select the downloaded Package "CodeScanner"
// 3.) In Tab General, add Framework "CodeScanner"
//
// 4.) Request for Camera Usage, ie. in Info.plist add
//     Privacy - Camera Usage Description
//     NSCameraUsageDescription
// 5.) Import the Package "CodeScanner"
import CodeScanner

struct QRCodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScannerView()
    }
}

struct QRCodeScannerView: View {
    @State var isPresentingScanner = false
    @State var scannedCode: String?

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                if self.scannedCode != nil {
                    if let code = self.scannedCode {
                        Text(code)
                
                    }
                }
                Button("Scan Code") {
                    self.isPresentingScanner = true
                }
                .sheet(isPresented: $isPresentingScanner) {
                    self.scannerSheet
                }
                Text("Scan a QR code to begin")
            }

        }
    }

    var scannerSheet : some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: { scanResult in
                if case let .success(qrcode) = scanResult {
                    self.scannedCode = qrcode.string
                    self.isPresentingScanner = false
                }
            }
        )
    }
}
