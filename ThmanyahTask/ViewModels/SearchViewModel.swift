//
//  SearchViewModel.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 10/08/2025.
//

import Foundation
import Observation

@MainActor
class SearchViewModel: ObservableObject {
    private let httpClient: HTTPClient
    
    @Published var searchText = ""
    private var searchTask: Task<Void, Never>? // to cancel previous debounce

    @Published var searchResult: [ModelSection] = []
    @Published var isLoading = false
    
    // DI
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func debounceSearch() {
        // Cancel any ongoing search debounce
        searchTask?.cancel()
        
        // Create a new debounce task
        searchTask = Task {
            // Wait 200ms
            try? await Task.sleep(for: .milliseconds(200))
            
            // Cancel if this task was replaced
            guard !Task.isCancelled else { return }
            
            try? await performSearch()
        }
    }

    func performSearch() async throws {
        if isLoading { return }
        if searchText.isEmpty {
            searchResult = []
            return
        }
        isLoading = true
        let api = API.performSearch(query: searchText)
        let resource = GenericResource(url: api.path, method: api.method, modelType: BaseResponse.self)
        do {
            let response = try await httpClient.load(resource)
            var list = response?.sections ?? []
            list.shuffle()
            searchResult = list
            isLoading = false
        } catch {
            isLoading = false
            throw error
        }
    }
    
}
