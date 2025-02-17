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
        StaticConfiguration(kind: kind, provider: TimerProvider()) { entry in
            TimerWidgetView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("Life Timer - Timer Only")
        .description("남은 수명을 'YY년 mm개월 DD일' 형식으로 표시합니다.")
    }
}
