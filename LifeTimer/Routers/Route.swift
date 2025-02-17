//
//  Route.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/4/25.
//

import SwiftUI

/// URL 경로와 인자(선택)를 저장하는 라우트 모델
struct Route: Hashable {
    let name: String
    let arguments: [String: String]? // String key/value 형식
}
