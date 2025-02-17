//
//  UserDataManager.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/17/25.
//

import Foundation
import CoreData

class UserDataManager {
    static let shared = UserDataManager()
    private let userDefaults = UserDefaults(suiteName: "group.com.lifetimer.share") // ✅ App Group 사용
    private let viewContext: NSManagedObjectContext
    
    private init() {
        self.viewContext = CoreDataManager.shared.viewContext
    }
    
    /// CoreData에서 User 데이터 가져오기
    func fetchUser() -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.fetchLimit = 1
        do {
            let result = try viewContext.fetch(request)
            if let user = result.first {
                print("✅ Core Data에서 User 불러옴: \(user)")
            } else {
                print("🚨 Core Data에 User 데이터 없음")
            }
            return result.first
        } catch {
            print("🚨 User Fetch 실패: \(error)")
            return nil
        }
    }
    
    /// CoreData에 새로운 User 저장
    func saveUser(birthDate: Date, deathDate: Date) -> Bool {
        let newUser = User(context: viewContext)
        newUser.birth = birthDate
        newUser.death = deathDate
        
        do {
            try viewContext.save()
            print("✅ User 저장 완료: 예상 사망일 \(deathDate)")
            saveUserDataToUserDefaults(birthDate: birthDate, deathDate: deathDate)
            return true
        } catch {
            print("🚨 User 저장 실패: \(error)")
            return false
        }
    }
    
    /// CoreData에서 User 삭제 (데이터 초기화)
    func deleteUserData() -> Bool {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = User.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
            print("✅ 모든 User 데이터 삭제 완료")
            return true
        } catch {
            print("🚨 데이터 삭제 실패: \(error)")
            return false
        }
    }
    
    /// UserDefaults에 데이터 저장하는 함수
        func saveUserDataToUserDefaults(birthDate: Date, deathDate: Date) {
            let now = Date()
            let total = deathDate.timeIntervalSince(birthDate)
            let elapsed = now.timeIntervalSince(birthDate)
            let progress = min(max(elapsed / total, 0), 1)

            userDefaults?.set(deathDate, forKey: "deathDate")
            userDefaults?.set(progress, forKey: "progress")
            userDefaults?.synchronize() // ✅ 즉시 동기화

            print("✅ UserDefaults에 데이터 저장 완료 (deathDate: \(deathDate), progress: \(progress))")
        }
}
