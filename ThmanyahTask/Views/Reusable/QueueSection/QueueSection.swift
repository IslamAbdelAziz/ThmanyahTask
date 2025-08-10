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
            // Content
            if let content = section?.content as? [ModelContentPodcast] {
                QueueSectionItem(geo: geo, contentItem: BaseModelContent(from: (content.count > 3) ? content[3] : content.last), images: content.map({ $0.avatarUrl ?? "" }))
//                    .padding(.horizontal, 4)
            } else if let content = section?.content as? [ModelContentAudioBook] {
                QueueSectionItem(geo: geo, contentItem: BaseModelContent(from: content.last), images: content.map({ $0.avatarUrl ?? "" }))
//                    .padding(.horizontal, 4)
            } else if let content = section?.content as? [ModelContentAudioArticle] {
                QueueSectionItem(geo: geo, contentItem: BaseModelContent(from: content.last), images: content.map({ $0.avatarUrl ?? "" }))
//                    .padding(.horizontal, 4)
            } else if let content = section?.content as? [ModelContentEpisode] {
                QueueSectionItem(geo: geo, contentItem: BaseModelContent(from: content.last), images: content.map({ $0.avatarUrl ?? "" }))
//                    .padding(.horizontal, 4)
            }
        }
        .frame(width: geo.size.width, height: (geo.size.width * 0.3) + 60)
        .padding(.bottom, 8)
    }
}

#Preview {
    GeometryReader { geo in
        QueueSection(geo: geo, section: SectionsViewModel(httpClient: HTTPClient()).getSampleSection())
            .preferredColorScheme(.dark)
    }
}
