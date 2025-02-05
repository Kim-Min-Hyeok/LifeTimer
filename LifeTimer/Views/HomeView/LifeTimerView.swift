//
//  LifeTimerView.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/5/25.
//

import SwiftUI

struct LifeTimerView: View {
    let timeString: String
    
    var body: some View {
        Text(timeString)
            .font(.neoDunggeunmo(size: 30))
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .lineSpacing(35)
    }
}
