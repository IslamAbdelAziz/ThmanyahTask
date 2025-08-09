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
        GeometryReader { geo in
            NavigationStack {
                List {
                    ForEach(sectionViewModel.sectionsList) { section in
                        if section.type == .square {
                            SquareSection(geo: geo, section: section)
                        } else {
                            Text(section.name ?? "")
                        }
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
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
        .preferredColorScheme(.dark)
}
