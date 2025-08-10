//
//  TestSectionsViewModel.swift
//  ThmanyahTaskTests
//
//  Created by iSlam AbdelAziz on 10/08/2025.
//

import Testing
import Foundation

@testable import ThmanyahTask

struct TestSectionsViewModel {


    @MainActor
    @Test func testfetchSections() async throws {
        let sectionVM = SectionsViewModel(httpClient: HTTPClient())
        try await sectionVM.loadSections()
        #expect(sectionVM.sectionsList.count > 0)
    }
    
    @MainActor
    @Test func testInitalizeEmptySections() async throws {
        let sectionVM = SectionsViewModel(httpClient: HTTPClient())
        #expect(sectionVM.sectionsList.count == 0)
    }
    
    @MainActor
    @Test func testInitalizePageNumber() async throws {
        let sectionVM = SectionsViewModel(httpClient: HTTPClient())
        #expect(sectionVM.getPageNumber() == 1)
    }
    
    @MainActor
    @Test func testUpdatePageNumber() async throws {
        let sectionVM = SectionsViewModel(httpClient: HTTPClient())
        try await sectionVM.loadSections()
        #expect(sectionVM.getPageNumber() == 2)
    }
    
    @MainActor
    @Test func testControlPaginationLogicHasMorePages() async throws {
        let sectionVM = SectionsViewModel(httpClient: HTTPClient())
        sectionVM.controlPaginationLogic(totalPages: 10)
        #expect(sectionVM.getPageNumber() == 2)
    }
    
    @MainActor
    @Test func testControlPaginationLogicHasNoMorePages() async throws {
        let sectionVM = SectionsViewModel(httpClient: HTTPClient())
        sectionVM.controlPaginationLogic(totalPages: 1)
        #expect(sectionVM.getPageNumber() == 1)
        #expect(sectionVM.getHasMoreSections() == false)
    }
    
    @MainActor
    @Test func testInitalizeHasMorePages() async throws {
        let sectionVM = SectionsViewModel(httpClient: HTTPClient())
        #expect(sectionVM.getHasMoreSections() == true)
    }
    
    @MainActor
    @Test func testValidatePagination() async throws {
        let sectionVM = SectionsViewModel(httpClient: HTTPClient())
        try await sectionVM.loadSections()
        let idx = sectionVM.sectionsList.count - 3
        #expect(sectionVM.validatePaginationAction(section: sectionVM.sectionsList[idx]) == true)
    }
    

}
