//
//  TwoLinesGridSection.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 09/08/2025.
//

import SwiftUI

struct TwoLinesGridSection: View {
    let geo: GeometryProxy
    let section: ModelSection?
    
    var body: some View {
        VStack {
            // header
            SectionTitleView(title: section?.name ?? "")
            // Content
            ScrollView(.horizontal) {
                LazyHGrid(rows: [
                    GridItem(.flexible(), spacing: 16),
                    GridItem(.flexible(), spacing: 16)
                ], spacing: 16) {
                    ForEach(section?.content ?? []) { item in
                        TwoLinesGridSectionItem(geo: geo, contentItem: item)
                            .padding(.horizontal, 4)
                    }
                }
            }
            .frame(maxHeight: ((geo.size.width * 0.2) * 2) + 40, alignment: .top)
            .scrollIndicators(.hidden)
            
        }
        .padding(.bottom, 4)
    }
}

#Preview {
    GeometryReader { geo in
        TwoLinesGridSection(geo: geo, section: SectionsViewModel(httpClient: HTTPClient()).getSampleSection())
            .preferredColorScheme(.dark)
    }
}
