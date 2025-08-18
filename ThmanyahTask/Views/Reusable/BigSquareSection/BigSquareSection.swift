//
//  BigSquareSection.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 09/08/2025.
//

import SwiftUI

struct BigSquareSection: View {
    let geo: GeometryProxy
    let section: ModelSection?
    
    var body: some View {
        VStack {
            // header
            SectionTitleView(title: section?.name ?? "")
                .padding(.bottom, -4)
            // Content
            ScrollView(.horizontal) {
                LazyHGrid(rows: [
                    GridItem(.fixed(geo.size.width * 0.5))
                ]) {
                    ForEach(section?.content ?? []) { item in
                        BigSquareSectionItem(geo: geo, contentItem: item)
                            .padding(.horizontal, 4)
                    }
                }
            }
            .frame(maxHeight: (geo.size.width * 0.35) + 100)
            .scrollIndicators(.hidden)
            
        }
    }
}

#Preview {
    GeometryReader { geo in
        BigSquareSection(geo: geo, section: SectionsViewModel(httpClient: HTTPClient()).getSampleSection())
            .preferredColorScheme(.dark)
    }
}
