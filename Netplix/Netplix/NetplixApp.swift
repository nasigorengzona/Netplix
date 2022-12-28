//
//  NetplixApp.swift
//  Netplix
//
//  Created by erlina ng on 27/12/22.
//

import SwiftUI

@main
struct NetplixApp: App {
    var body: some Scene {
        WindowGroup {
            LandingView()
                .environmentObject(SearchViewModel())
        }
    }
}
