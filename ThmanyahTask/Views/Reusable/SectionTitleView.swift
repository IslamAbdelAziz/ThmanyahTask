//
//  SectionTitle.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 09/08/2025.
//

import SwiftUI

struct SectionTitleView: View {
    let title: String
    var body: some View {
        HStack {
            // title
            Text(title)
                .appFont(.title, weight: .bold)
            Spacer()
            // navigation Arrow
            Image(systemName: "chevron.right")
                .imageScale(.large)
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    SectionTitleView(title: "اسمع قبل الناس")
}
