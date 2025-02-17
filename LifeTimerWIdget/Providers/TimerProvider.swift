//
//  TimerProvider.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/17/25.
//

import WidgetKit
import SwiftUI

struct TimerProvider: TimelineProvider {
    typealias Entry = LifeTimerEntry
    
    func placeholder(in context: Context) -> LifeTimerEntry {
        LifeTimerEntry(date: Date(), remainingTime: "00:00:00", progress: 0)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (LifeTimerEntry) -> Void) {
        let entry = LifeTimerEntry(date: Date(), remainingTime: WidgetDataManager.shared.getRemainingTime(), progress: 0)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<LifeTimerEntry>) -> Void) {
        // 단일 엔트리 반환 (실제 업데이트는 위젯 뷰 내부의 TimelineView가 처리)
        let entry = LifeTimerEntry(date: Date(), remainingTime: WidgetDataManager.shared.getRemainingTime(), progress: 0)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}
