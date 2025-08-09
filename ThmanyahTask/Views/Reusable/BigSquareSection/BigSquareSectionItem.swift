//
//  BigSquareSectionItem.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 09/08/2025.
//

import SwiftUI

struct BigSquareSectionItem: View {
    let geo: GeometryProxy
    var contentItem: BaseModelContent?
    
    var body: some View {
        ZStack {
            // Cover Image
            AsyncImage(url: URL(string: contentItem?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: geo.size.width * 0.70, height: geo.size.width * 0.5)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
            VStack(alignment: .leading) {
                Spacer()
                Text(contentItem?.name ?? "")
                    .lineLimit(1)
                    .appFont(.title2, weight: .semibold)
//                Text(contentItem?.name ?? "")
//                    .lineLimit(1)
//                    .appFont(.body, weight: .light)
//                    .padding(.bottom, 8)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .frame(width: geo.size.width * 0.70, alignment: .leading)
        }
        .frame(width: geo.size.width * 0.70, height: geo.size.width * 0.5)
    }
}

#Preview {
    GeometryReader { geo in
        BigSquareSectionItem(geo: geo, contentItem: BaseModelContent(from: (SectionsViewModel(httpClient: HTTPClient()).getSampleSection()?.content?[0] as? ModelContentPodcast)))
            .preferredColorScheme(.dark)
            .padding(.top, 40)
    }
}
