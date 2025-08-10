//
//  QueueSectionItem.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 09/08/2025.
//

import SwiftUI

struct QueueSectionItem: View {
    let geo: GeometryProxy
    var contentItem: BaseModelContent?
    var images: [String]

    var body: some View {
        HStack {
            HStack {
                HStack(spacing: -geo.size.width * 0.25){
                    // Queue Images
                    ForEach ((images.count > 4) ? 0..<4 : images.indices, id: \.self) { idx in
                        AsyncImage(url: URL(string: images[idx])) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: geo.size.width * 0.3, height: geo.size.width * 0.3)
                    }
                }
                VStack(alignment: .leading) {
//                    Spacer()
                    Text(contentItem?.name ?? "")
                        .appFont(.body, weight: .semibold)
                        .padding(.bottom, -4)
                        .lineLimit(nil)
                        .layoutPriority(1)
                    HStack {
                        Text(contentItem?.durationText ?? "")
                            .foregroundStyle(.orange.mix(with: .red, by: 0.5))
                            .appFont(.caption2, weight: .text)
                        Text("قبل 5 ساعات")
                            .foregroundStyle(.gray)
                            .appFont(.caption2, weight: .text)
                    }
                    HStack {
                        Spacer()
                        Image(systemName: "play.fill")
                            .imageScale(.medium)
                            .font(.headline)
                            .padding(8)
                            .foregroundStyle(.black)
                            .background(.white)
                            .clipShape(.circle)
                    }
                }
                .padding(8)
            }
            .padding()
        }
        .frame(width: geo.size.width * 0.95, height: (geo.size.width * 0.3) + 24)
        .background(.blue.opacity(0.2).mix(with: .gray, by: 0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    GeometryReader { geo in
        QueueSectionItem(geo: geo, contentItem: BaseModelContent(from: (SectionsViewModel(httpClient: HTTPClient()).getSampleSection()?.content?[1] as? ModelContentPodcast)), images: [
            "https://content.production.cdn.art19.com/images/b1/00/ad/c3/b100adc3-b65d-4ac9-9ab8-90b15cbc0013/39b12791ec1dad478f4fa2d08d00f2adbbdd8826319ff4efc35165647fe3760d2aeed81ca792953b99fdac6ee7dc24f39457c178e0595df0a83c3dda427b3d16.jpeg",
            "https://content.production.cdn.art19.com/images/b1/00/ad/c3/b100adc3-b65d-4ac9-9ab8-90b15cbc0013/39b12791ec1dad478f4fa2d08d00f2adbbdd8826319ff4efc35165647fe3760d2aeed81ca792953b99fdac6ee7dc24f39457c178e0595df0a83c3dda427b3d16.jpeg",
            "https://content.production.cdn.art19.com/images/b1/00/ad/c3/b100adc3-b65d-4ac9-9ab8-90b15cbc0013/39b12791ec1dad478f4fa2d08d00f2adbbdd8826319ff4efc35165647fe3760d2aeed81ca792953b99fdac6ee7dc24f39457c178e0595df0a83c3dda427b3d16.jpeg",
            "https://content.production.cdn.art19.com/images/b1/00/ad/c3/b100adc3-b65d-4ac9-9ab8-90b15cbc0013/39b12791ec1dad478f4fa2d08d00f2adbbdd8826319ff4efc35165647fe3760d2aeed81ca792953b99fdac6ee7dc24f39457c178e0595df0a83c3dda427b3d16.jpeg"
])
            .padding()
            .preferredColorScheme(.dark)
    }
    
}
