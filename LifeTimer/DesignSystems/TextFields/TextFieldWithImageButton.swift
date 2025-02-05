//
//  TextFieldWithImageButton.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/5/25.
//

import SwiftUI

struct TextFieldWithImageButton: View {
    @Binding var text: String
    var image: Image
    var buttonAction: () -> Void
    
    var body: some View {
        HStack {
            TextField("", text: $text)
                .padding(8)
                .frame(height: 50)
            
            Button(action: buttonAction) {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
            .padding(.trailing, 8)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.black, lineWidth: 3)
        )
        .padding()
    }
}
