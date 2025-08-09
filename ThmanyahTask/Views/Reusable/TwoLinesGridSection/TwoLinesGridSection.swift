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
                .padding(.bottom, -8)
            // Content
            ScrollView(.horizontal) {
                LazyHGrid(rows: [
                    GridItem(.flexible(), spacing: 4),
                    GridItem(.flexible(), spacing: 4)
                ]) {
                    if let content = section?.content as? [ModelContentPodcast] {
                        ForEach(content) { item in
                            TwoLinesGridSectionItem(geo: geo, contentItem: BaseModelContent(from: item))
                                .padding(.horizontal, 4)
                        }
                    } else if let content = section?.content as? [ModelContentAudioBook] {
                        ForEach(content) { item in
                            TwoLinesGridSectionItem(geo: geo, contentItem: BaseModelContent(from: item))
                                .padding(.horizontal, 4)
                        }
                    } else if let content = section?.content as? [ModelContentAudioArticle] {
                        ForEach(content) { item in
                            TwoLinesGridSectionItem(geo: geo, contentItem: BaseModelContent(from: item))
                                .padding(.horizontal, 4)
                        }
                    } else if let content = section?.content as? [ModelContentEpisode] {
                        ForEach(content) { item in
                            TwoLinesGridSectionItem(geo: geo, contentItem: BaseModelContent(from: item))
                                .padding(.horizontal, 4)
                        }
                    }
                }
            }
            .frame(maxHeight: ((geo.size.width * 0.2) * 2) + 30, alignment: .top)
            .scrollIndicators(.hidden)
            
        }
    }
}

#Preview {
    GeometryReader { geo in
        TwoLinesGridSection(geo: geo, section: SectionsViewModel(httpClient: HTTPClient()).getSampleSection())
            .preferredColorScheme(.dark)
    }
}
