//
//  SettingView.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/4/25.
//

import SwiftUI
import CoreData

struct SettingView: View {
    let context: NSManagedObjectContext
    @EnvironmentObject var router: NavigationRouter
    @StateObject private var viewModel: SettingViewModel
    @State private var showingResetAlert = false
    
    init(context: NSManagedObjectContext) {
        self.context = context
        _viewModel = StateObject(wrappedValue: SettingViewModel(context: context))
    }
    
    var body: some View {
        ZStack() {
        VStack() {
            HStack() {
                Button(action: router.back
                ) {
                    Image("arrow_back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                .frame(height: 50)
                .padding(.horizontal, -12)
                
                Spacer()
            }
            .padding(.bottom, 7)
            
            Button(action: {
                showingResetAlert = true
            }) {
                HStack {
                    Text("초기화")
                        .font(.neoDunggeunmo(size: 18))
                        .foregroundColor(.black)
                        .padding(.leading, 15)
                    Spacer()
                }
                .frame(height: 50)
            }
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black),
                alignment: .bottom
            )
            
            Spacer()
        }
        .safeAreaPadding(.horizontal, 12)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        if showingResetAlert {
            // 배경 디밍 효과
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            // 중앙에 Alert 배치
            CustomAlert(
                title: "정말로 초기화 하시겠습니까?",
                confirmAction: {
                    if viewModel.resetData() {
                        router.offAll("/surveyIntro")
                    }
                    showingResetAlert = false
                },
                cancelAction: {
                    showingResetAlert = false
                }
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
}

