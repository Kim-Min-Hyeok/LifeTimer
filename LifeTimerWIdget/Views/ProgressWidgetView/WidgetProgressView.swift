//
//  WidgetProgressView.swift
//  LifeTimerWidget
//
//  Created by Minhyeok Kim on 2/17/25.
//

import SwiftUI

struct WidgetProgressView: View {
    let progress: Double

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 8)
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.blue)
                    .frame(width: geo.size.width * CGFloat(progress), height: 8)
            }
        }
        .frame(height: 8)
        .padding(.horizontal, 5)
    }
}
