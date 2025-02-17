//
//  ProgressWidget.swift
//  LifeTimerWIdgetExtension
//
//  Created by Minhyeok Kim on 2/17/25.
//

import WidgetKit
import SwiftUI

struct ProgressWidget: Widget {
    let kind: String = "ProgressWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ProgressProvider()) { _ in
            ProgressWidgetView()
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("Life Timer - Progress Only")
        .description("남은 수명을 프로그래스바로 표시합니다.")
    }
}
