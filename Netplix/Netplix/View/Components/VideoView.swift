//
//  VideoView.swift
//  Netplix
//
//  Created by erlina ng on 28/12/22.
//

import SwiftUI
import WebKit

struct VideoView : UIViewRepresentable {
    let videoId : IdVideoElement
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let trailerURL = URL(string: "https://www.youtube.com/embed/\(videoId.videoId)") else {return}
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: trailerURL))
    }
}
