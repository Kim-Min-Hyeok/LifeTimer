//
//  ExitApp.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/13/25.
//

import UIKit

func exitApp() {
    UIApplication.shared.perform(#selector(NSXPCConnection.suspend)) // 백그라운드 상태로 전환 후 종료
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        exit(0) // 최종 종료 (Apple 심사 기준을 고려하여 백그라운드 전환 후 실행)
    }
}
