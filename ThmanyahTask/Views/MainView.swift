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
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28)
                            .foregroundStyle(.green.mix(with: .white, by: 0.5))
                        Text("Welcome, Islam")
                            .appFont(.title, weight: .semibold)
                    }
                    .padding(.vertical, 8)
                    .modifier(ListSectionViewModifier())
                    ForEach(sectionViewModel.sectionsList) { section in
                        switch(section.type) {
                        case .square:
                            SquareSection(geo: geo, section: section)
                                .modifier(ListSectionViewModifier())
                                .onAppear {
                                    if sectionViewModel.validatePaginationAction(section: section) {
                                        fetchSections()
                                    }
                                }
                        case .bigSquare, .bigSpaceSquare:
                            BigSquareSection(geo: geo, section: section)
                                .modifier(ListSectionViewModifier())
                                .onAppear {
                                    if sectionViewModel.validatePaginationAction(section: section) {
                                        fetchSections()
                                    }
                                }
                        case .twoLinesGrid:
                            TwoLinesGridSection(geo: geo, section: section)
                                .modifier(ListSectionViewModifier())
                                .onAppear {
                                    if sectionViewModel.validatePaginationAction(section: section) {
                                        fetchSections()
                                    }
                                }
                        case .queue:
                            QueueSection(geo: geo, section: section)
                                .modifier(ListSectionViewModifier())
                                .onAppear {
                                    if sectionViewModel.validatePaginationAction(section: section) {
                                        fetchSections()
                                    }
                                }
                            
                        default:
                            Text(section.name ?? "")
                        }
                    }
                    if sectionViewModel.isLoading {
                        ProgressView("Loading...")
                            .frame(maxWidth: .infinity)
                    }
                    
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                .refreshable {
                    fetchSections(reload: true)
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
            fetchSections()
        }
    }
    
    func fetchSections(reload: Bool = false) {
        Task {
            try await sectionViewModel.loadSections(reload: reload)
        }
    }
}
#Preview {
    MainView()
        .preferredColorScheme(.dark)
}
