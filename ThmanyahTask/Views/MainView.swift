//
//  ContentView.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 08/08/2025.
//

import SwiftUI

struct MainView: View {
    @Environment(SectionsViewModel.self) private var sectionViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sectionViewModel.sectionsList) { section in
                    Text(section.name ?? "")
                }
            }
        }
        .onAppear {
            Task {
                do {
                    try await sectionViewModel.loadSections()
                } catch {
                    
                }
            }
        }
    }
}

#Preview {
    MainView()
        .environment(SectionsViewModel(httpClient: HTTPClient()))
}
