//
//  PDFKitView.swift
//  NetworkTest
//
//  Created by Arslan Abdullaev on 17.04.2022.
//

import SwiftUI
import PDFKit
struct PDFKitView: View {
    @StateObject var viewModel =  PDFKitViewModel()
    var url: URL? {
        viewModel.url
    }
        
    var body: some View {
        
        PDFKitRepresentedView(url: url)
    }
}

struct PDFKitRepresentedView : UIViewRepresentable {
    
    private var url: URL?
    
    init(url: URL?) {
        self.url = url
    }

    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        let pdfView = PDFView()

        if let url = url {
            pdfView.document = PDFDocument(url: url)
                    
            }
        
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
        // Update the view.
    }
}

