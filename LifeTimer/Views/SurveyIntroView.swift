//
//  SurveyIntroView.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/5/25.
//

import SwiftUI

struct SurveyIntroView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        VStack (alignment: .center){
            Text(
                "사용자의 예상 수명을 계산하기 위해\n간단한 설문조사가 진행됩니다."
            )
            .font(.neoDunggeunmo(size: 18))
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.top, 100)
            
            Spacer()
            
            Text("사용자님의 개인 정보는\n사용자님의 휴대폰에만 저장이 되며,\n어떠한 개인정보도\n저희 앱으로 전송되지 않습니다.")
                .font(.neoDunggeunmo(size: 12))
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.bottom, 80)
            
            OctagonButton(title: "설문조사 할래요!") {
                router.toNamed("/survey")
            }
            .padding(.bottom, 111)
        }
        // 네비게이션 바와 뒤로가기 버튼 숨기기
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SurveyIntroView()
}
