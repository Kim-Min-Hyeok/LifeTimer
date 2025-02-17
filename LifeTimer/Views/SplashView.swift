//
//  SplashView.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/5/25.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                Text("Life\nTimer")
                    .font(.neoDunggeunmo(size: 30))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                Image("app_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }
        }
        // 네비게이션 바와 뒤로가기 버튼 숨기기
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
