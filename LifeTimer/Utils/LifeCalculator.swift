//
//  LifeCaclulator.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/5/25.
//

import Foundation

/// 기대수명 계산 결과를 담는 구조체
struct LifeCalculationResult {
    let lifeExpectancy: Int    // 계산된 기대수명(년)
    let remainingYears: Int    // 남은 년수 (기대수명 - 현재 나이)
    let remainingDays: Int     // 남은 일수 (남은 년수 * 365)
}

/// 설문 응답 배열을 받아 기대수명을 계산하는 함수
/// - Parameter answers: SurveyViewModel의 answers 배열 (인덱스 순서대로 27개 항목)
/// - Returns: 계산 결과(LifeCalculationResult) 또는 응답 형식 오류 시 nil
func calculateLife(with answers: [SurveyAnswer?]) -> LifeCalculationResult? {
    // 응답 항목이 27개 미만이면 계산 불가
    guard answers.count >= 27 else { return nil }
    
    // Q1. 나이 (몇살이십니까?)
    guard case let .intInput(ageStr)? = answers[0],
          let age = Int(ageStr) else { return nil }
    
    // Q2. 당신은 어떻게 살기를 추구합니까?
    // 옵션: ["짧고 굵게", "남들 사는 것 만큼", "얇고 길게"]
    // 매핑: 0 → 60, 1 → 76, 2 → 99
    let lifeOption: Int = {
        guard case let .button(index)? = answers[1] else { return 0 }
        switch index {
        case 0: return 60
        case 1: return 76
        case 2: return 99
        default: return 60
        }
    }()
    
    // Q3. 성별 – ["남자", "여자"]
    // 매핑: 남자(0) → -3, 여자(1) → +4
    let genderValue: Int = {
        guard case let .button(index)? = answers[2] else { return 0 }
        return (index == 0) ? -3 : 4
    }()
    
    // Q4 ~ Q25는 대부분 이진 선택이므로, 아래 헬퍼 함수를 사용합니다.
    func binaryValue(for answerIndex: Int, yesValue: Int, noValue: Int) -> Int {
        guard case let .button(index)? = answers[answerIndex] else { return 0 }
        return (index == 0) ? yesValue : noValue
    }
    
    // Q4. "2백만명 이상의 인구를 가진 도시 지역에 살고 있습니까?"
    // 옵션: ["예", "아니요"] → 예일 경우 -2, 아니요는 0
    let q4 = binaryValue(for: 3, yesValue: -2, noValue: 0)
    
    // Q5. "만명 이하의 읍이나 농지에 사십니까?"
    // 예 → +2, 아니요 → 0
    let q5 = binaryValue(for: 4, yesValue: 2, noValue: 0)
    
    // Q6. "한명의 조부모가 85세까지 사셨습니까?"
    let q6 = binaryValue(for: 5, yesValue: 2, noValue: 0)
    
    // Q7. "외가,친가 합쳐서 조부모 4명이 모두 80세까지 사셨습니까?"
    let q7 = binaryValue(for: 6, yesValue: 6, noValue: 0)
    
    // Q8. "부모가 50이전에 뇌졸중이나 심장마비로 사망하신적이 있습니까?"
    let q8 = binaryValue(for: 7, yesValue: -4, noValue: 0)
    
    // Q9. "부모나 형제,혹은 누이가 50세 이하에 암이나 심장병이 있거나, 아동기 이후 당뇨병이 있습니까?"
    let q9 = binaryValue(for: 8, yesValue: -3, noValue: 0)
    
    // Q10. "일년에 6000천만원 이상을 법니까?"
    let q10 = binaryValue(for: 9, yesValue: -2, noValue: 0)
    
    // Q11. "대학을 졸업했습니까?"
    let q11 = binaryValue(for: 10, yesValue: 1, noValue: 0)
    
    // Q12. "대학원 학위나 전문직 자격증이 있습니까?"
    let q12 = binaryValue(for: 11, yesValue: 2, noValue: 0)
    
    // Q13. "65세 또는 그 이상이고 아직 일을 하고 있습니까?"
    let q13 = binaryValue(for: 12, yesValue: 3, noValue: 0)
    
    // Q14. "배우자나 친구와 함께 살고 있습니까?"
    let q14 = binaryValue(for: 13, yesValue: 5, noValue: 0)
    
    // Q15. "책상에서 일하십니까?"
    // 예 → -3, 아니요 → +3
    let q15 = binaryValue(for: 14, yesValue: -3, noValue: 3)
    
    // Q16. "일이 정규적이고, 무거운 육체 노동을 요구하십니까?"
    let q16 = binaryValue(for: 15, yesValue: 3, noValue: 0)
    
    // Q17. "일주일에 다섯 번을 적어도 30분씩 지속적으로 운동하십니까?(테니스,달리기,수영등)"
    let q17 = binaryValue(for: 16, yesValue: 4, noValue: 0)
    
    // Q18. "일주일에 두 번 혹은 3 번 운동하십니까?"
    let q18 = binaryValue(for: 17, yesValue: 2, noValue: 0)
    
    // Q19. "매일 10시간 이상씩 잡니까?"
    let q19 = binaryValue(for: 18, yesValue: -4, noValue: 0)
    
    // Q20. "성격이 감정적이고, 공격적이고 쉽게 화를 냅니까?"
    let q20 = binaryValue(for: 19, yesValue: -3, noValue: 0)
    
    // Q21. "편안히 생각하고 쉽니까?"
    let q21 = binaryValue(for: 20, yesValue: -3, noValue: 0)
    
    // Q22. "행복합니까? 아니면 불행합니까?"
    // 옵션: ["행복", "불행"] → 행복(인덱스 0)일 경우 +1, 불행은 0
    let q22: Int = {
        guard case let .button(index)? = answers[21] else { return 0 }
        return (index == 0) ? 1 : 0
    }()
    
    // Q23. "작년에 속도 위반 딱지를 땠습니까?"
    let q23 = binaryValue(for: 22, yesValue: -2, noValue: 0)
    
    // Q24. "여성이고 일년에 한번 산부인과 의사를 찾으십니까?(남자는 아니요)"
    let q24 = binaryValue(for: 23, yesValue: 2, noValue: 0)
    
    // Q25. "40세 이상이고 매년 건강 체크를 하십니까?"
    let q25 = binaryValue(for: 24, yesValue: 2, noValue: 0)
    
    // Q26. "하루에 담배를 얼마나 피우십니까?"
    // 옵션: ["두갑 이상", "한갑~두갑", "한갑~반갑", "피우지 않음"]
    // 매핑: 0 → -8, 1 → -6, 2 → -3, 3 → 0
    let q26: Int = {
        guard case let .button(index)? = answers[25] else { return 0 }
        switch index {
        case 0: return -8
        case 1: return -6
        case 2: return -3
        case 3: return 0
        default: return 0
        }
    }()
    
    // Q27. "키와 몸무게를 입력하세요"
    // 계산: 이상적 몸무게 B = (키 - 100) * 0.9, 상한선 sang = B + 10
    // over = (실제 몸무게 - sang)
    // over가 23 이상이면 -8, 13 이상이면 -4, 5 이상이면 -2의 페널티 적용
    var penalty: Int = 0
    if let answer = answers[26],
       case let .intPair(tallStr, weightStr) = answer,
       let tall = Int(tallStr),
       let weight = Int(weightStr) {
        let idealWeight = Double(tall - 100) * 0.9
        let sang = idealWeight + 10
        let over = Double(weight) - sang
        if over >= 23 {
            penalty = 8
        } else if over >= 13 {
            penalty = 4
        } else if over >= 5 {
            penalty = 2
        }
    }
    
    // 추가 나이 기반 가산점
    // 나이에 따라: 30~39세: +2, 40~49세: +3, 50~69세: +4, 70세 이상: +5
    let ageAddition: Int = {
        if age >= 30 && age < 40 {
            return 2
        } else if age >= 40 && age < 50 {
            return 3
        } else if age >= 50 && age < 70 {
            return 4
        } else if age >= 70 {
            return 5
        }
        return 0
    }()
    
    // 최종 합계 계산
    let total = lifeOption + genderValue + q4 + q5 + q6 + q7 + q8 + q9 + q10 +
                q11 + q12 + q13 + q14 + q15 + q16 + q17 + q18 + q19 + q20 + q21 +
                q22 + q23 + q24 + q25 + q26 + ageAddition - penalty
    
    // 남은 년수 및 일수 계산
    let remainingYears = total - age
    let remainingDays = remainingYears * 365
    
    return LifeCalculationResult(lifeExpectancy: total,
                                 remainingYears: remainingYears,
                                 remainingDays: remainingDays)
}
