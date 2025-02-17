//
//  WidgetProgressView.swift
//  LifeTimerWidget
//
//  Created by Minhyeok Kim on 2/17/25.
//

import SwiftUI

struct WidgetProgressView: View {
    let progress: Double

    var body: some View {
        GeometryReader { geo in
            let barWidth = geo.size.width
            let barHeight: CGFloat = 5
            ZStack(alignment: .bottomLeading) {
                // 흰색 배경에 검정 테두리와 진행률 막대
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.red1)
                        .frame(height: barHeight)
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: barWidth * CGFloat(progress), height: barHeight)
                }
                .frame(maxWidth: .infinity, alignment: .bottom)
                
                // runner 이미지는 그대로 유지
                if progress > 0 {
                    Image("runner")
                        .resizable()
                        .frame(width: 50, height: 40)
                        .offset(
                            x: barWidth * CGFloat(progress) - 25,
                            y: -barHeight - 2
                        )
                }
            }
        }
        // 최대 너비를 infinity로 지정하여 부모 컨테이너의 전체 너비를 채우도록 함
        .frame(maxWidth: .infinity)
        // 좌우 패딩을 제거하여 최대한 넓게 사용 (필요 시 조절)
        .padding(0)
    }
}
