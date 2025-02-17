//
//  ProgressProvider.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/17/25.
//

import WidgetKit
import SwiftUI

struct ProgressProvider: TimelineProvider {
    typealias Entry = LifeTimerEntry
    
    func placeholder(in context: Context) -> LifeTimerEntry {
        LifeTimerEntry(date: Date(), remainingTime: "", progress: 0.75)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (LifeTimerEntry) -> Void) {
        let entry = LifeTimerEntry(date: Date(), remainingTime: "", progress: WidgetDataManager.shared.getProgress())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<LifeTimerEntry>) -> Void) {
        let entry = LifeTimerEntry(date: Date(), remainingTime: "", progress: WidgetDataManager.shared.getProgress())
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}
