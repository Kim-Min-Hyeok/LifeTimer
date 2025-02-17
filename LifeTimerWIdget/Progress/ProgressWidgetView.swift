//
//  LifeTimerProgressWidgetView.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/17/25.
//
import SwiftUI
import WidgetKit

struct ProgressWidgetView: View {
    var entry: LifeTimerEntry
    
    var body: some View {
        VStack {
            Text("HP")
                .font(.neoDunggeunmo(size: 18))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineSpacing(35)
            WidgetProgressView(progress: entry.progress)
        }
        .padding()
        .containerBackground(Color.black.opacity(0.8), for: .widget)
    }
}
