//
//  CoreDataManager.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/17/25.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "LifeTimer") // ✅ 프로젝트의 Core Data 모델 이름과 동일해야 함

        if let appGroupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.lifetimer.share") {
            let storeURL = appGroupURL.appendingPathComponent("LifeTimer.sqlite")
            let description = NSPersistentStoreDescription(url: storeURL)
            persistentContainer.persistentStoreDescriptions = [description]
        }

        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("🚨 Core Data 로드 실패: \(error.localizedDescription)")
            }
        }
    }

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
