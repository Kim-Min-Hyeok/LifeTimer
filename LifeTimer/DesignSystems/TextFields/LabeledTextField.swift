//
//  LabeledTextField.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/5/25.
//

import SwiftUI

struct LabeledTextField: View {
    var label: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.neoDunggeunmo(size: 14))
            TextField("", text: $text)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.black, lineWidth: 3)
                )
        }
        .padding()
    }
}
