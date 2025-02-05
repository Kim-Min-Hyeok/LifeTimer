//
//  HomeViewModel.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/4/25.
//

import Foundation
import CoreData
import Combine

class HomeViewModel: ObservableObject {
    // 단일 User를 저장 (User가 한 명만 있다고 가정)
    @Published var user: User? = nil
    @Published var now: Date = Date()
    
    private let viewContext: NSManagedObjectContext
    private var cancellables = Set<AnyCancellable>()
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchUser()
        
        // 1초마다 현재 시각(now) 업데이트
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] time in
                self?.now = time
            }
            .store(in: &cancellables)
    }
    
    /// Core Data에서 단일 User를 Fetch (User가 한 명만 저장되어 있다고 가정)
    func fetchUser() {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.fetchLimit = 1
        do {
            let result = try viewContext.fetch(request)
            self.user = result.first
        } catch {
            print("🚨 Error fetching user: \(error)")
            self.user = nil
        }
    }
    
    /// 남은 시간 문자열 ("YY년 mm개월 dd일\nHH:mm:ss")를 계산합니다.
    var remainingTimeString: String {
        guard let user = user, let deathDate = user.death else { return "" }
        
        let components = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: now,
            to: deathDate
        )
        let years = components.year ?? 0
        let months = components.month ?? 0
        let days = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
        return "\(years)년 \(months)개월 \(days)일\n\(String(format: "%02d", hours)):\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
    }
    
    /// 진행률: (현재 시각 - 출생일) / (예상 사망일 - 출생일)
    var progress: Double {
        guard let user = user,
              let birthDate = user.birth,
              let deathDate = user.death else { return 0 }
        let total = deathDate.timeIntervalSince(birthDate)
        let elapsed = now.timeIntervalSince(birthDate)
        return min(max(elapsed / total, 0), 1)
    }
}
