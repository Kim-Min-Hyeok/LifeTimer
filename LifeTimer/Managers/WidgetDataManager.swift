//
//  WidgetDataManager.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/17/25.
//

import Foundation

class WidgetDataManager {
    static let shared = WidgetDataManager()
    private let userDefaults = UserDefaults(suiteName: "group.com.lifetimer.share")
    
    private init() {}
    
    func getBirthDate() -> Date? {
        return userDefaults?.object(forKey: "birthDate") as? Date
    }
    
    func getDeathDate() -> Date? {
        return userDefaults?.object(forKey: "deathDate") as? Date
    }
    
    /// UserDefaults에서 남은 시간 가져오기
    func getRemainingTime() -> String {
        guard let deathDate = userDefaults?.object(forKey: "deathDate") as? Date else {
            print("🚨 UserDefaults에서 deathDate를 가져오지 못함")
            return "데이터 없음"
        }
        
        let now = Date()
        let components = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: now,
            to: deathDate
        )
        
        return """
        \(components.year ?? 0)년 \(components.month ?? 0)개월 \(components.day ?? 0)일
        \(String(format: "%02d", components.hour ?? 0)):\(String(format: "%02d", components.minute ?? 0)):\(String(format: "%02d", components.second ?? 0))
        """
    }
    
    /// UserDefaults에서 진행률 가져오기
    func getProgress() -> Double {
        return userDefaults?.double(forKey: "progress") ?? 0
    }
    
    /// UserDefaults에 데이터 저장
    func saveUserData(birthDate: Date, deathDate: Date) {
        userDefaults?.set(deathDate, forKey: "deathDate")
        let total = deathDate.timeIntervalSince(birthDate)
        let elapsed = Date().timeIntervalSince(birthDate)
        let progress = min(max(elapsed / total, 0), 1)
        userDefaults?.set(progress, forKey: "progress")
    }
}

