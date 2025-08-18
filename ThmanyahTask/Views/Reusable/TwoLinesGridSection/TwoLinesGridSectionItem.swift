//
//  TwoLinesGridSectionItem.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 09/08/2025.
//

import SwiftUI

struct TwoLinesGridSectionItem: View {
    let geo: GeometryProxy
    var contentItem: MixedContentValue?
    
    var body: some View {
        HStack {
            // Cover Image
            AsyncImage(url: URL(string: contentItem?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            } placeholder: {
                ProgressView()
            }
            .frame(width: geo.size.width * 0.2, height: geo.size.width * 0.2)
            VStack(alignment: .leading) {
                Text("قبل 5 ساعات")
                    .foregroundStyle(.gray)
                    .appFont(.caption2, weight: .text)
                Spacer()
                Text(contentItem?.autherAndTitle ?? "")
                    .lineLimit(2)
                    .appFont(.body, weight: .semibold)
                    .padding(.bottom, -4)
                Spacer()
                HStack {
                    DurationView(duration: contentItem?.durationText ?? "")
                    Spacer()
                    Spacer()
                    Image(systemName: "ellipsis")
                    Spacer()
                    Image(systemName: "text.badge.plus")

                }
            }
        }
        .frame(width: geo.size.width * 0.8, height: (geo.size.width * 0.2))
    }
}

#Preview {
    GeometryReader { geo in
        TwoLinesGridSectionItem(geo: geo, contentItem: SectionsViewModel(httpClient: HTTPClient()).getSampleSection()?.content?[1])
            .padding()
            .preferredColorScheme(.dark)
    }

}
