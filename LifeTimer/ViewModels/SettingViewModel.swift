//
//  SettingViewModel.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/6/25.
//

import Foundation
import CoreData

class SettingViewModel: ObservableObject {
    
    /// Core Data 데이터 초기화
    func resetData() -> Bool {
        return UserDataManager.shared.deleteUserData()
    }
}
