//
//  SquareSectionItem.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 08/08/2025.
//

import SwiftUI

struct SquareSectionItem: View {
    let geo: GeometryProxy
    var contentItem: BaseModelContent?

    var body: some View {
        VStack(alignment: .leading) {
                // Cover Image
                AsyncImage(url: URL(string: contentItem?.avatarUrl ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                } placeholder: {
                    ProgressView()
                }
                .frame(width: geo.size.width * 0.35, height: geo.size.width * 0.35)
                
            Text(contentItem?.name ?? "")
                .lineLimit(1)
                .appFont(.body, weight: .semibold)
                .padding(.bottom, -4)
            DurationView(duration: contentItem?.durationText ?? "")
        }
        .frame(width: geo.size.width * 0.35, height: (geo.size.width * 0.35) + 100, alignment: .leading)
    }
}

#Preview {
    GeometryReader { geo in
        SquareSectionItem(geo: geo, contentItem: BaseModelContent(from: (SectionsViewModel(httpClient: HTTPClient()).getSampleSection()?.content?[0] as? ModelContentPodcast)))
            .preferredColorScheme(.dark)
    }
}
