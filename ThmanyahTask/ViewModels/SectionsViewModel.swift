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
    private var hasMoreSections = true

    // DI
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func loadSections() async throws {
        let api = API.getHomeScreenSections(pageNumber: homeScreenPageNumber)
        let resource = GenericResource(url: api.path, method: api.method, modelType: BaseResponse.self)
        do {
            let response = try await httpClient.load(resource)
            sectionsList = response?.sections ?? []
            controlPaginationLogic(totalPages: response?.pagination?.totalPages)
        } catch {
//            failover()
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
