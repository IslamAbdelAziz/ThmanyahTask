//
//  BigSquareSectionItem.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 09/08/2025.
//

import SwiftUI

struct BigSquareSectionItem: View {
    let geo: GeometryProxy
    var contentItem: MixedContentValue?
    
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
            .frame(width: geo.size.width * 0.60, height: geo.size.width * 0.45)
            .overlay {
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: .clear, location: 0.5),
                        Gradient.Stop(color: .black.opacity(0.5), location: 1),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            
            VStack(alignment: .leading) {
                Spacer()
                Text(contentItem?.name ?? "")
                    .lineLimit(1)
                    .appFont(.title2, weight: .semibold)
                Text("\(Int.random(in: 0...20)) Episodes")
                    .lineLimit(1)
                    .appFont(.body, weight: .light)
                    .padding(.bottom, 8)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .frame(width: geo.size.width * 0.60, alignment: .leading)
        }
        .frame(width: geo.size.width * 0.60, height: geo.size.width * 0.45)
    }
}

#Preview {
    GeometryReader { geo in
        BigSquareSectionItem(geo: geo, contentItem: SectionsViewModel(httpClient: HTTPClient()).getSampleSection()?.content?[0])
            .preferredColorScheme(.dark)
            .padding(.top, 40)
    }
}
