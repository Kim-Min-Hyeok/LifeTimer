//
//  LifeTimerApp.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/4/25.
//

import SwiftUI

@main
struct LifeTimerApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        updateUserDefaultsData()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
    private func updateUserDefaultsData() {
        if let user = UserDataManager.shared.fetchUser(), let birth = user.birth, let death = user.death {
            UserDataManager.shared.saveUserDataToUserDefaults(birthDate: birth, deathDate: death)
        } else {
            print("🚨 User 데이터가 존재하지 않아 UserDefaults 업데이트를 건너뜁니다.")
        }
    }
}
