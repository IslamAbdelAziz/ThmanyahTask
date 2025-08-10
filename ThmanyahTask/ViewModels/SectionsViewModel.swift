//
//  SectionsDataStore.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 08/08/2025.
//

import Foundation
import Observation

@Observable
@MainActor
class SectionsViewModel {
    private let httpClient: HTTPClient
    
    var sectionsList: [ModelSection] = []
    private var homeScreenPageNumber: Int = 1
    var isLoading = false
    private var hasMoreSections = true

    // DI
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func loadSections(reload: Bool = false) async throws {
        if isLoading, !hasMoreSections { return }
        if reload {
            sectionsList.removeAll()
            homeScreenPageNumber = 1
            hasMoreSections = true
        }
        isLoading = true
        let api = API.getHomeScreenSections(pageNumber: homeScreenPageNumber)
        let resource = GenericResource(url: api.path, method: api.method, modelType: BaseResponse.self)
        do {
            let response = try await httpClient.load(resource)
            sectionsList.append(contentsOf: response?.sections ?? [])
            controlPaginationLogic(totalPages: response?.pagination?.totalPages)
            isLoading = false
        } catch {
//            failover()
            isLoading = false
            throw error
        }
    }
    
    private
    func controlPaginationLogic(totalPages: Int?) {
        if let totalPages = totalPages, homeScreenPageNumber < totalPages {
            homeScreenPageNumber += 1
            hasMoreSections = true
        } else {
            hasMoreSections = false
        }
    }
    func validatePaginationAction(section: ModelSection) -> Bool {
        if let idx = sectionsList.firstIndex(where: {$0.id == section.id}) {
            if idx == sectionsList.count - 3 && hasMoreSections {
                print(idx)
                return true
            }
        }
        return false
    }
    
    /// This function will fetch data from local json file in case of Failure
    private func failover() {
        let data = try? Data(contentsOf: Bundle.main.url(forResource: "sections", withExtension: "json")!)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        if let sectionsData = data {
            do {
                let response = try decoder.decode(BaseResponse.self, from: sectionsData)
                if let sections = response.sections {
                    self.sectionsList = sections
                }
            } catch {
                print("DECODING ERROR \(error)")
            }
        }
        
    }
    
    func getSampleSection() -> ModelSection? {
        failover()
        return self.sectionsList.first
    }
}
