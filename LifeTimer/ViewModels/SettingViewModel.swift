//
//  SettingViewModel.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/6/25.
//

import Foundation
import CoreData

class SettingViewModel: ObservableObject {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func resetData() -> Bool {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("모든 데이터를 삭제했습니다.")
            return true
        } catch {
            print("데이터 삭제 오류: \(error)")
            return false
        }
    }
}
