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
        let currentDate = Date()
        var entries: [LifeTimerEntry] = []
        
        // 향후 24시간 동안 4시간 간격으로 엔트리 생성
        for hourOffset in stride(from: 0, to: 24, by: 4) {
            guard let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate) else {
                continue
            }
            
            let entry = LifeTimerEntry(
                date: entryDate,
                remainingTime: WidgetDataManager.shared.getRemainingTime(),
                progress: 0
            )
            entries.append(entry)
        }
        
        // 마지막 엔트리 이후 4시간 뒤에 새로운 타임라인 요청
        let refreshDate = Calendar.current.date(byAdding: .hour, value: 4, to: entries[entries.count-1].date) ?? Date()
        let timeline = Timeline(entries: entries, policy: .after(refreshDate))
        
        completion(timeline)
    }
}
