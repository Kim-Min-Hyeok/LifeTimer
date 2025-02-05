//
//  SurveyQuestion.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/5/25.
//

import SwiftUI

enum QuestionType {
    case intInput                     // 예: "몇살이십니까?" (숫자 입력)
    case buttons(options: [String])   // 예: "어떻게 살기를 추구합니까?" 등 (버튼 선택)
    case intPair                      // 예: "키와 몸무게를 입력하세요" (두 개의 숫자 입력)
}

struct SurveyQuestion: Identifiable {
    let id = UUID()
    let questionText: String
    let type: QuestionType
}
