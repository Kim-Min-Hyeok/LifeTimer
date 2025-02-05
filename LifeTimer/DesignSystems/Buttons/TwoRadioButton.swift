//
//  TwoRadioButton.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/4/25.
//

import SwiftUI

struct TwoRadioButton: View {
    /// 선택된 인덱스 (0 또는 1)
    @Binding var selectedIndex: Int
    var optionTitles: [String] = ["옵션 1", "옵션 2"]
    var onSelection: (() -> Void)?
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                selectedIndex = 0
                onSelection?()
            }) {
                Text(optionTitles[0])
                    .font(.neoDunggeunmo(size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .background(Color.blue1)
            
            Button(action: {
                selectedIndex = 1
                onSelection?()
            }) {
                Text(optionTitles[1])
                    .font(.neoDunggeunmo(size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .background(Color.red1)
        }
        .padding()
    }
}
