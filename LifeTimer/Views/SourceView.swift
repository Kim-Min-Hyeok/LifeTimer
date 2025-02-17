//
//  SourceView.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/13/25.
//

import SwiftUI

struct SourceView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
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
            Text("📌 기대 수명 계산 출처")
                .font(.neoDunggeunmo(size: 18))
                .padding(.bottom, 5)
            
            Text("- 원전, D.K. Hannis, *노년의 사회학*")
                .font(.neoDunggeunmo(size: 12))
                .foregroundColor(.gray)
            
            Text("- 미국 보험업계에서 일반적으로 사용되는 기대수명 계측 시스템")
                .font(.neoDunggeunmo(size: 12))
                .foregroundColor(.gray)
            
            Spacer()
        }
        .safeAreaPadding(.horizontal, 18)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
