//
//  LifeTimerProgressWidgetView.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/17/25.
//
import SwiftUI
import WidgetKit

struct ProgressWidgetView: View {
    private let viewModel = ProgressWidgetViewModel()
    
    var body: some View {
        TimelineView(.periodic(from: Date(), by: 1)) { context in
            let progress = viewModel.getProgress()
            
            VStack {
                Text("진행률")
                    .font(.caption)
                    .foregroundColor(.gray)
                WidgetProgressView(progress: progress)
                Text(String(format: "진행률: %.2f%%", progress * 100))
                    .font(.caption)
            }
            .padding()
            .background(Color(hex: "272727")) // 배경색 지정
            .containerBackground(Color(hex: "272727"), for: .widget) // 위젯 컨테이너 배경 적용
        }
    }
}
