//
//  TimerWidgetViewModel.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/17/25.
//

import Foundation

class TimerWidgetViewModel {
    private let dataManager = WidgetDataManager.shared

    func getRemainingTime() -> String {
        return dataManager.getRemainingTime()
    }
}
