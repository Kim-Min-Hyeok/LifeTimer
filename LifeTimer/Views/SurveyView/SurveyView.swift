//
//  SurveyView.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/5/25.
//

import SwiftUI
import CoreData

struct SurveyView: View {
    
    @EnvironmentObject var router: NavigationRouter
    @StateObject private var viewModel = SurveyViewModel()
    
    var body: some View {
        VStack() {
            HStack() {
                Button(action: {
                    if viewModel.currentQuestionIndex > 0 {
                        viewModel.goToPreviousQuestion()
                    } else {
                        router.back()
                    }
                }) {
                    Image("arrow_back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                .frame(height: 50)
                
                Spacer()
            }
            .padding(.bottom, 120)
            
            if let question = viewModel.currentQuestion {
                Text(question.questionText)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 100)
                
                switch question.type {
                case .intInput:
                    // 숫자 input
                    TextFieldWithImageButton(text: $viewModel.intInputResponse, image: Image("arrow_next"), buttonAction: viewModel.goToNextQuestion)
                    
                case .buttons(let options):
                    Group {
                        if options.count == 2 {
                            TwoRadioButton(selectedIndex: $viewModel.buttonSelectedIndex, optionTitles: options,
                                           onSelection: viewModel.goToNextQuestion
                            )
                        } else {
                            MultipleRadioButton(titles: options, selectedIndex: $viewModel.buttonSelectedIndex,
                                                onSelection: viewModel.goToNextQuestion
                            )
                        }
                    }
                    
                case .intPair:
                    // 두 개의 정수 입력: 두 개의 LabeledTextField를 HStack에 배치
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            LabeledTextField(label: "키 (cm)", text: $viewModel.intPairResponse1)
                            LabeledTextField(label: "몸무게 (kg)", text: $viewModel.intPairResponse2)
                        }
                    }
                    .padding()
                }
                
                // 하단 버튼: 마지막 질문이면 "제출", 아니면 "다음"
                if viewModel.currentQuestionIndex == viewModel.questions.count - 1 {
                    OctagonButton(title: "내 수명 계산하기") {
                        if(viewModel.submitSurvey()) {
                            router.offAll("/")
                        }
                    }
                }
                Spacer()
            } else {
                Text("설문이 완료되었습니다.")
                    .font(.largeTitle)
                    .padding()
            }
        }
        // 네비게이션 바와 뒤로가기 버튼 숨기기
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        .overlay(
            Group {
                if let message = viewModel.toastMessage {
                    ToastView(message: message)
                        .transition(.opacity)
                }
            },
            alignment: .bottom
        )
        .onChange(of: viewModel.toastMessage) { oldValue, newValue in
            if newValue != nil {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        viewModel.toastMessage = nil
                    }
                }
            }
        }
    }
}
