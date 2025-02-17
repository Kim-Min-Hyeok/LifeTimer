//
//  SurveyAnswer.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/5/25.
//

import SwiftUI

enum SurveyAnswer {
    case intInput(String)         // 예: 몇살이십니까? → "30" 등
    case button(Int)              // 버튼형 질문 → 선택된 인덱스
    case intPair(String, String)  // 두 개의 정수 입력 → (키, 몸무게)
}
