//
//  ToastView.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/6/25.
//

import SwiftUI

struct ToastView: View {
    let message: String
    
    var body: some View {
        Text(message)
            .font(.neoDunggeunmo(size: 16))
            .foregroundColor(.white)
            .padding()
            .background(Color.black.opacity(0.5))
            .padding(.bottom, 50)
    }
}
