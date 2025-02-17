//
//  TimerWidget.swift
//  LifeTimerWIdgetExtension
//
//  Created by Minhyeok Kim on 2/17/25.
//

import WidgetKit
import SwiftUI

struct TimerWidget: Widget {
    let kind: String = "TimerWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TimerProvider()) { _ in
            TimerWidgetView()
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("Life Timer - Timer Only")
        .description("남은 수명을 타이머로 표시합니다.")
    }
}
