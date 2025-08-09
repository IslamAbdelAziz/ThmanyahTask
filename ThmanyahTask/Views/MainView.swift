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
//            if sectionViewModel.sectionsList.isEmpty {
//                ContentUnavailableView {
//                    Image(.emptyFolder)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 200)
//                        .foregroundStyle(.gray)
//                } description: {
//                    Text("There are no Data yet, Fetch it please")
//                        .font(.headline)
//                } actions: {
//                    Button ("Fetch Data", systemImage: "antenna.radiowaves.left.and.right") {
//                        Task {
//                            try await sectionViewModel.loadSections()
//                        }
//                    }
//                    .buttonStyle(.borderedProminent)
//                    .font(.title3)
//                    
//                }
//                
//            } else {
                NavigationStack {
                    List {
                        ForEach(sectionViewModel.sectionsList) { section in
                            switch(section.type) {
                            case .square:
                                SquareSection(geo: geo, section: section)
                                    .modifier(ListSectionViewModifier())
                            case .bigSquare, .bigSpaceSquare:
                                BigSquareSection(geo: geo, section: section)
                                    .modifier(ListSectionViewModifier())
                            case .twoLinesGrid:
                                TwoLinesGridSection(geo: geo, section: section)
                                    .modifier(ListSectionViewModifier())
                            case .queue:
                                QueueSection(geo: geo, section: section)
                                    .modifier(ListSectionViewModifier())
                            default:
                                Text(section.name ?? "")
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollIndicators(.hidden)
                    .refreshable {
                        do {
                            try await sectionViewModel.loadSections()
                        } catch {
                            
                        }
                    }
                }
            }
        .onAppear {
            Task {
                try await sectionViewModel.loadSections()
            }
        }
//        }
    }
}
#Preview {
    MainView()
        .preferredColorScheme(.dark)
}
