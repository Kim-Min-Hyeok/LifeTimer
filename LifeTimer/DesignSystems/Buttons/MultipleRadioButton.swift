//
//  MultipleRadioButton.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/4/25.
//

import SwiftUI

struct MultipleRadioButton: View {
    var titles: [String]
    @Binding var selectedIndex: Int
    var onSelection: (() -> Void)? = nil
    
    // 미리 설정한 기본 색상 배열 (필요에 따라 수정)
    private let defaultColors: [Color] = [Color.red1, Color.orange1, Color.blue2, Color.purple1]
    
    var body: some View {
        VStack(spacing: 30) {
            ForEach(titles.indices, id: \.self) { index in
                Button(action: {
                    selectedIndex = index
                    onSelection?()
                }) {
                    Text(titles[index])
                        .font(.neoDunggeunmo(size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .background(defaultColors[index % defaultColors.count])
            }
        }
        .padding()
    }
}
