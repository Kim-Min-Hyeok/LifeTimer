//
//  ProgressWidgetViewModel.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/17/25.
//

import Foundation

class ProgressWidgetViewModel {
    private let dataManager = WidgetDataManager.shared

    func getProgress() -> Double {
        return dataManager.getProgress()
    }
}
