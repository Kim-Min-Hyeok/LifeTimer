//
//  HomeView.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/4/25.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @EnvironmentObject var router: NavigationRouter
    @StateObject private var viewModel = HomeViewModel()

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
            
            Spacer()
            
            Link("기대 수명 계산 출처", destination: URL(string: "https://github.com/Kim-Min-Hyeok/LifeTimer/blob/main/Citations%26References.md")!)
                .font(.neoDunggeunmo(size: 10))
                .foregroundColor(.blue1)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
