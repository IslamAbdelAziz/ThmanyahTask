//
//  DurationView.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 09/08/2025.
//

import SwiftUI

struct DurationView: View {
    let duration: String
    var body: some View {
        HStack {
            HStack(spacing: 4) {
                // duration
                Image(systemName: "play.fill")
                    .imageScale(.small)
                    .font(.caption2)
                Text(duration)
                    .appFont(.caption, weight: .medium)
            }
            .frame(height: 36)
            .padding(.horizontal, 12)
            .background(.gray.opacity(0.4))
            .clipShape(.capsule)
//            .padding(.horizontal, 8)
            .foregroundStyle(.white)
            Spacer()
        }
    }
}

#Preview {
    DurationView(duration: (SectionsViewModel(httpClient: HTTPClient()).getSampleSection()?.content?[0] as? ModelContentPodcast)?.durationText ?? "")
        .preferredColorScheme(.dark)
}
