//
//  SurveyViewModel.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/5/25.
//

import Foundation
import Combine
import CoreData

final class SurveyViewModel: ObservableObject {
    // 전체 질문 배열
    @Published var questions: [SurveyQuestion] = []
    // 현재 질문 인덱스
    @Published var currentQuestionIndex: Int = 0
    
    // 각 질문에 대한 임시 응답값
    @Published var intInputResponse: String = ""      // 예: 몇 살 입력
    // 버튼형 질문의 선택 인덱스 (-1이면 아직 선택 안 된 상태)
    @Published var buttonSelectedIndex: Int = -1
    // 두 정수 입력 (예: 키와 몸무게)
    @Published var intPairResponse1: String = ""
    @Published var intPairResponse2: String = ""
    
    // 각 질문의 응답을 저장하는 배열 (질문 수와 같은 길이로 초기화)
    @Published var answers: [SurveyAnswer?] = []
    
    // 토스트 메시지 (유효하지 않은 응답 시)
    @Published var toastMessage: String? = nil
    
    init() {
        loadQuestions()
        // 질문 수 만큼 답변 배열 초기화 (모두 nil)
        answers = Array(repeating: nil, count: questions.count)
    }
    
    /// 질문 배열 초기화
    private func loadQuestions() {
        var qs = [SurveyQuestion]()
        
        qs.append(SurveyQuestion(
            questionText: "몇살이십니까?",
            type: .intInput))
        
        qs.append(SurveyQuestion(
            questionText: "어떻게 살기를 추구합니까?",
            type: .buttons(options: ["짧고 굵게 (부정적)", "남들 사는 것 만큼 (권장)", "얇고 길게 (긍정적)"])))
        
        qs.append(SurveyQuestion(
            questionText: "남자입니까? 여자입니까?",
            type: .buttons(options: ["남자", "여자"])))
        
        qs.append(SurveyQuestion(
            questionText: "2백만명 이상의 인구를 가진 도시 지역에\n살고 있습니까?",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "만명 이하의 읍이나 농지에\n사십니까?",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "한명의 조부모가 85세까지\n사셨습니까?",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "외가,친가 합쳐서 조부모 4명이\n모두 80세까지 사셨습니까?",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "부모가 50이전에 뇌졸중이나 심장마비로\n사망하신적이 있습니까?",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "부모나 형제,혹은 누이가\n50세 이하에 암이나 심장병이 있거나,\n아동기 이후 당뇨병이 있습니까?",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "일년에 6000천만원 이상을 법니까?",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "대학을 졸업했습니까?",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "대학원 학위나 전문직 자격증이 있습니까?",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "65세 또는 그 이상이고\n아직 일을 하고 있습니까?",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "배우자나 친구와 함께 살고 있습니까?",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "책상에서 일하십니까?",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "일이 정규적이고,\n무거운 육체 노동을 요구하십니까?",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "일주일에 다섯 번을 적어도\n30분씩 지속적으로 운동하십니까?\n(테니스,달리기,수영등)",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "일주일에 두 번 혹은 3번 운동하십니까?",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "매일 10시간 이상씩 잡니까?",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "성격이 감정적이고, 공격적이고 쉽게 화를 냅니까?",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "편안히 생각하고 쉽니까?",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "행복합니까? 아니면 불행합니까?",
            type: .buttons(options: ["행복", "불행"])))
        
        qs.append(SurveyQuestion(
            questionText: "작년에 속도 위반 딱지를 땠습니까?",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "여성이고 일년에 한번\n산부인과 의사를 찾으십니까?(남자는 아니요)",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "40세 이상이고 매년 건강 체크를 하십니까?",
            type: .buttons(options: ["예", "아니요"])))
        
        qs.append(SurveyQuestion(
            questionText: "하루에 담배를 얼마나 피우십니까?",
            type: .buttons(options: ["두갑 이상", "한갑~두갑", "한갑~반갑", "피우지 않음"])))
        
        qs.append(SurveyQuestion(
            questionText: "키와 몸무게를 입력하세요",
            type: .intPair))
        
        self.questions = qs
    }
    
    /// 현재 질문 반환
    var currentQuestion: SurveyQuestion? {
        guard currentQuestionIndex < questions.count else { return nil }
        return questions[currentQuestionIndex]
    }
    
    // 현재 질문의 응답을 저장하는 함수
    private func saveCurrentAnswer() {
        guard currentQuestionIndex < questions.count else { return }
        let question = questions[currentQuestionIndex]
        switch question.type {
        case .intInput:
            answers[currentQuestionIndex] = .intInput(intInputResponse)
        case .buttons:
            answers[currentQuestionIndex] = .button(buttonSelectedIndex)
        case .intPair:
            answers[currentQuestionIndex] = .intPair(intPairResponse1, intPairResponse2)
        }
    }
    
    // 현재 질문의 저장된 응답을 불러오는 함수
    private func loadAnswerForCurrentQuestion() {
        guard currentQuestionIndex < questions.count else { return }
        
        // 응답 초기화를 먼저 수행
        intInputResponse = ""
        buttonSelectedIndex = -1
        intPairResponse1 = ""
        intPairResponse2 = ""
        
        // 그 다음 저장된 응답이 있으면 로드
        if let answer = answers[currentQuestionIndex] {
            switch answer {
            case .intInput(let text):
                intInputResponse = text
            case .button(let index):
                buttonSelectedIndex = index
            case .intPair(let first, let second):
                intPairResponse1 = first
                intPairResponse2 = second
            }
        }
    }
    
    /// Validator
    /// 현재 질문에 대해 응답이 비어있거나 올바르지 않으면 false 반환
    private func isCurrentAnswerValid() -> Bool {
        guard currentQuestionIndex < questions.count else { return false }
        let question = questions[currentQuestionIndex]
        switch question.type {
        case .intInput:
            // 공백이 아니고, 정수로 변환 가능한지 검사
            let trimmed = intInputResponse.trimmingCharacters(in: .whitespacesAndNewlines)
            return !trimmed.isEmpty && Int(trimmed) != nil
        case .buttons:
            // 선택된 인덱스가 -1이 아니어야 함
            return buttonSelectedIndex != -1
        case .intPair:
            // 두 입력 모두 공백이 아니고 정수로 변환 가능한지 검사
            let trimmed1 = intPairResponse1.trimmingCharacters(in: .whitespacesAndNewlines)
            let trimmed2 = intPairResponse2.trimmingCharacters(in: .whitespacesAndNewlines)
            return !trimmed1.isEmpty && !trimmed2.isEmpty && Int(trimmed1) != nil && Int(trimmed2) != nil
        }
    }
    
    /// 다음 질문으로 이동 (현재 응답 저장 후)
    func goToNextQuestion() {
        guard isCurrentAnswerValid() else {
            print("현재 질문에 대한 응답이 유효하지 않습니다.")
            toastMessage = "응답이 유효하지 않습니다."
            return
        }
        saveCurrentAnswer()
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            loadAnswerForCurrentQuestion()
        }
    }
    
    /// 이전 질문으로 이동 (현재 응답 저장 후)
    func goToPreviousQuestion() {
        saveCurrentAnswer()
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
            loadAnswerForCurrentQuestion()
        }
    }
    
    /// 설문 제출 처리 (실제 저장/전송 로직 추가)
    func submitSurvey() -> Bool {
        saveCurrentAnswer() // 마지막 질문 응답 저장
        
        // (응답 로그 출력)
        for (index, answer) in answers.enumerated() {
            print("Q\(index + 1): \(answer.map { "\($0)" } ?? "없음")")
        }
        
        // 기대수명 계산 (calculateLife 함수는 LifeCalculator.swift에 정의되어 있음)
        guard let result = calculateLife(with: answers) else {
            print("설문 응답 데이터에 오류가 있습니다.")
            return false
        }
        print("기대수명: \(result.lifeExpectancy)년")
        print("남은 년수: \(result.remainingYears)년")
        print("남은 일수: \(result.remainingDays)일")
        
        // Q1에서 입력한 나이 값을 사용하여 현재 나이 계산
        guard case let .intInput(ageStr)? = answers[0],
              let currentAge = Int(ageStr) else {
            print("🚨 나이 입력 오류")
            return false
        }
        
        // 출생일: 오늘 날짜에서 currentAge년 빼기
        let birthDate = Calendar.current.date(byAdding: .year, value: -currentAge, to: Date()) ?? Date()
        // 예상 사망일: 오늘 날짜에서 (기대수명 - 현재 나이)년 더하기
        let remainingYears = calculateLife(with: answers)?.lifeExpectancy ?? 80 - currentAge
        let deathDate = Calendar.current.date(byAdding: .year, value: remainingYears, to: Date()) ?? Date()
        
        // ✅ UserDataManager를 사용하여 Core Data 저장
        return UserDataManager.shared.saveUser(birthDate: birthDate, deathDate: deathDate)
    }
}
