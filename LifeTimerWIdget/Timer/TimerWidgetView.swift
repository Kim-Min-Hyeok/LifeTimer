//
//  TimerWidgetView.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/17/25.
//

import SwiftUI
import WidgetKit

struct TimerWidgetView: View {
    var entry: LifeTimerEntry
    
    var body: some View {
        VStack {
            Text(entry.remainingTime)
                .font(.neoDunggeunmo(size: 28))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineSpacing(35)
                .padding(8)
            Text("남았습니다...")
                .font(.neoDunggeunmo(size: 12))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineSpacing(35)
        }
        .padding()
        .containerBackground(Color.black.opacity(0.8), for: .widget)
    }
}
