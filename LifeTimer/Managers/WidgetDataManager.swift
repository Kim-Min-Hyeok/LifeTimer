//
//  WidgetDataManager.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/17/25.
//

import Foundation
import WidgetKit

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
    
    /// UserDefaults에서 남은 시간을 "YY년 mm개월 DD일" 형식으로 계산하여 반환
    func getRemainingTime() -> String {
        guard let deathDate = userDefaults?.object(forKey: "deathDate") as? Date else {
            print("🚨 UserDefaults에서 deathDate를 가져오지 못함")
            return "데이터 없음"
        }
        
        let now = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day], from: now, to: deathDate)
        let years = components.year ?? 0
        let months = components.month ?? 0
        let days = components.day ?? 0
        
        return "\(years)년 \(months)개월 \(days)일"
    }
    
    /// UserDefaults에서 진행률 가져오기
    func getProgress() -> Double {
        return userDefaults?.double(forKey: "progress") ?? 0
    }
    
    /// UserDefaults에 데이터 저장
    func saveUserData(birthDate: Date, deathDate: Date) {
        userDefaults?.set(birthDate, forKey: "birthDate")
        userDefaults?.set(deathDate, forKey: "deathDate")
        // (진행률 계산은 앱에서 별도로 업데이트하도록 할 수 있음)
        WidgetCenter.shared.reloadAllTimelines()
        print("✅ UserDefaults에 데이터 저장 완료: birthDate=\(birthDate), deathDate=\(deathDate)")
    }
}
