//
//  TimerWidgetView.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/17/25.
//

import SwiftUI
import WidgetKit

struct TimerWidgetView: View {
    // 뷰모델은 뷰 내부에서 생성합니다.
    private let viewModel = TimerWidgetViewModel()
    
    var body: some View {
        // TimelineView를 사용하여 위젯이 활성화된 동안 매초 업데이트합니다.
        TimelineView(.periodic(from: Date(), by: 1)) { context in
            let remainingTime = viewModel.getRemainingTime()
            
            VStack {
                Text(remainingTime)
                    .font(.neoDunggeunmo(size: 28))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineSpacing(35)
            }
            .padding()
            .background(Color(hex: "272727"))
            .containerBackground(Color(hex: "272727"), for: .widget)
        }
    }
}
