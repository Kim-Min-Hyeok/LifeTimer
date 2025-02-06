//
//  HomeView.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/4/25.
//

import SwiftUI
import CoreData

struct HomeView: View {
    let context: NSManagedObjectContext
    @EnvironmentObject var router: NavigationRouter
    @StateObject private var viewModel: HomeViewModel
    
    init(context: NSManagedObjectContext) {
        self.context = context
        _viewModel = StateObject(wrappedValue: HomeViewModel(context: context))
    }
    
    var body: some View {
        VStack {
            // 상단 설정 버튼
            HStack {
                Spacer()
                Button(action: {
                    router.toNamed("/setting")
                }) {
                    Image("setting")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                .frame(height: 50)
            }
            
            Spacer()
            
            if !viewModel.remainingTimeString.isEmpty {
                // 남은 시간 텍스트
                LifeTimerView(timeString: viewModel.remainingTimeString)
                    .padding(.bottom, 100)
                
                // Progress Bar (CustomProgressView)
                ProgressView(progress: viewModel.progress)
                    .padding(.bottom, 100)
                    .padding()
            } else {
                Text("수명 데이터가 없습니다.")
                    .font(.title)
                    .padding(.bottom, 100)
            }
            
            Text("늦었다고 생각될 땐,\n진짜 늦은거다")
                .font(.neoDunggeunmo(size: 18))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 150)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
