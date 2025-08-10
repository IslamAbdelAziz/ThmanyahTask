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
                    if let content = section?.content as? [ModelContentPodcast] {
                        ForEach(content) { item in
                            BigSquareSectionItem(geo: geo, contentItem: BaseModelContent(from: item))
                                .padding(.horizontal, 4)
                        }
                    } else if let content = section?.content as? [ModelContentAudioBook] {
                        ForEach(content) { item in
                            BigSquareSectionItem(geo: geo, contentItem: BaseModelContent(from: item))
                                .padding(.horizontal, 4)
                        }
                    } else if let content = section?.content as? [ModelContentAudioArticle] {
                        ForEach(content) { item in
                            BigSquareSectionItem(geo: geo, contentItem: BaseModelContent(from: item))
                                .padding(.horizontal, 4)
                        }
                    } else if let content = section?.content as? [ModelContentEpisode] {
                        ForEach(content) { item in
                            BigSquareSectionItem(geo: geo, contentItem: BaseModelContent(from: item))
                                .padding(.horizontal, 4)
                        }
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
