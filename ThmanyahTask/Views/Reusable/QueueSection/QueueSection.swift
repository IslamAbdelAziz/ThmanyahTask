//
//  QueueSection.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 09/08/2025.
//

import SwiftUI

struct QueueSection: View {
    let geo: GeometryProxy
    let section: ModelSection?
    
    var body: some View {
        VStack {
            // header
            SectionTitleView(title: section?.name ?? "")
                .padding(.bottom, -4)
            // Content
            if let content = section?.content as? [ModelContentPodcast] {
                QueueSectionItem(geo: geo, contentItem: BaseModelContent(from: content.first), images: content.map({ $0.avatarUrl ?? "" }))
                    .padding(.horizontal, 4)
            } else if let content = section?.content as? [ModelContentAudioBook] {
                QueueSectionItem(geo: geo, contentItem: BaseModelContent(from: content.first), images: content.map({ $0.avatarUrl ?? "" }))
                    .padding(.horizontal, 4)
            } else if let content = section?.content as? [ModelContentAudioArticle] {
                QueueSectionItem(geo: geo, contentItem: BaseModelContent(from: content.first), images: content.map({ $0.avatarUrl ?? "" }))
                    .padding(.horizontal, 4)
            } else if let content = section?.content as? [ModelContentEpisode] {
                QueueSectionItem(geo: geo, contentItem: BaseModelContent(from: content.first), images: content.map({ $0.avatarUrl ?? "" }))
                    .padding(.horizontal, 4)
            }
        }
        .frame(width: geo.size.width * 0.9, height: (geo.size.width * 0.3) + 24)
    }
}

#Preview {
    GeometryReader { geo in
        QueueSection(geo: geo, section: SectionsViewModel(httpClient: HTTPClient()).getSampleSection())
            .preferredColorScheme(.dark)
    }
}
