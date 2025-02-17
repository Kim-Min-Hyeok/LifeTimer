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
    @Published var user: User? = nil
    @Published var now: Date = Date()
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchUser()
        
        // 1초마다 현재 시각(now) 업데이트
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] time in
                self?.now = time
            }
            .store(in: &cancellables)
    }
    
    /// Core Data에서 User 데이터를 가져옴
    func fetchUser() {
        self.user = UserDataManager.shared.fetchUser()
    }
    
    /// 남은 시간 문자열을 반환
    var remainingTimeString: String {
        guard let user = user, let deathDate = user.death else { return "데이터 없음" }

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
    
    /// 진행률 계산
    var progress: Double {
        guard let user = user,
              let birthDate = user.birth,
              let deathDate = user.death else { return 0 }

        let total = deathDate.timeIntervalSince(birthDate)
        let elapsed = now.timeIntervalSince(birthDate)
        return min(max(elapsed / total, 0), 1)
    }
}
