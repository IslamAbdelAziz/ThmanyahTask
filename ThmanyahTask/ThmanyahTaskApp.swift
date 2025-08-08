//
//  ThmanyahTaskApp.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 08/08/2025.
//

import SwiftUI

@main
struct ThmanyahTaskApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(SectionsViewModel(httpClient: HTTPClient()))
        }
    }
}
