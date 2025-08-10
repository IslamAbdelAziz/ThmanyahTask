//
//  SearchView.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 10/08/2025.
//

import SwiftUI

struct SearchView: View {
    @StateObject var searchViewModel = SearchViewModel(httpClient: HTTPClient())
    @FocusState var isSearchFocused: Bool
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                List {
                    if searchViewModel.isLoading {
                        ProgressView()
                            .frame(width: geo.size.width, height: geo.size.height)
                    } else {
                        ForEach(searchViewModel.searchResult) { section in
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
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                .searchable(text: $searchViewModel.searchText)
                .autocorrectionDisabled()
                .onChange(of: searchViewModel.searchText) {
                    searchViewModel.debounceSearch()
                }
                .focused($isSearchFocused)
            }
        }
    }
}

#Preview {
    SearchView()
}
