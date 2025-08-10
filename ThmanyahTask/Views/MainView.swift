//
//  ContentView.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 08/08/2025.
//

import SwiftUI

struct MainView: View {
    @State var sectionViewModel = SectionsViewModel(httpClient: HTTPClient())
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                List {
                    if sectionViewModel.isLoading {
                        ProgressView()
                            .frame(width: geo.size.width, height: geo.size.height * 0.7)
                            .modifier(ListSectionViewModifier())
                    } else {
                        ForEach(sectionViewModel.sectionsList) { section in
                            switch(section.type) {
                            case .square:
                                SquareSection(geo: geo, section: section)
                                    .modifier(ListSectionViewModifier())
                                    .onAppear {
                                        if sectionViewModel.sectionsList.isThresholdItem(offset: 5, item: section) { // Load 5 items early
                                            Task {
                                                try await sectionViewModel.loadSections()
                                            }
                                        }
                                    }
                                if sectionViewModel.isLoading && sectionViewModel.sectionsList.isLastItem(section) {
                                    ProgressView("Loading...")
                                        .frame(maxWidth: .infinity)
                                }
                            case .bigSquare, .bigSpaceSquare:
                                BigSquareSection(geo: geo, section: section)
                                    .modifier(ListSectionViewModifier())
                                    .onAppear {
                                        if sectionViewModel.sectionsList.isThresholdItem(offset: 5, item: section) { // Load 5 items early
                                            Task {
                                                try await sectionViewModel.loadSections()
                                            }
                                        }
                                    }
                                if sectionViewModel.isLoading && sectionViewModel.sectionsList.isLastItem(section) {
                                    ProgressView("Loading...")
                                        .frame(maxWidth: .infinity)
                                }
                            case .twoLinesGrid:
                                TwoLinesGridSection(geo: geo, section: section)
                                    .modifier(ListSectionViewModifier())
                                    .onAppear {
                                        if sectionViewModel.sectionsList.isThresholdItem(offset: 5, item: section) { // Load 5 items early
                                            Task {
                                                try await sectionViewModel.loadSections()
                                            }
                                        }
                                    }
                                if sectionViewModel.isLoading && sectionViewModel.sectionsList.isLastItem(section) {
                                    ProgressView("Loading...")
                                        .frame(maxWidth: .infinity)
                                }
                                
                            case .queue:
                                QueueSection(geo: geo, section: section)
                                    .modifier(ListSectionViewModifier())
                                    .onAppear {
                                        if sectionViewModel.sectionsList.isThresholdItem(offset: 5, item: section) { // Load 5 items early
                                            Task {
                                                try await sectionViewModel.loadSections()
                                            }
                                        }
                                    }
                                if sectionViewModel.isLoading && sectionViewModel.sectionsList.isLastItem(section) {
                                    ProgressView("Loading...")
                                        .frame(maxWidth: .infinity)
                                }
                                
                            default:
                                Text(section.name ?? "")
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                .refreshable {
                    do {
                        try await sectionViewModel.loadSections(reload: true)
                    } catch {
                        
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            SearchView()
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .onAppear {
            Task {
                try await sectionViewModel.loadSections(reload: true)
            }
        }
    }
}
#Preview {
    MainView()
        .preferredColorScheme(.dark)
}
