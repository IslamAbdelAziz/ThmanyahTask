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
            if let content = section?.content, !content.isEmpty {
                QueueSectionItem(geo: geo, contentItem: (content.count > 3) ? content[3] : content.last, images: content.map{$0.avatarUrl})
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
