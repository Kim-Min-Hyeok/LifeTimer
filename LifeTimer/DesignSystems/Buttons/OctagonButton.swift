//
//  OctagonButton.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/4/25.
//

import SwiftUI

struct OctagonShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // 대각선을 5px로 고정
        let cutLength: CGFloat = 5
        let x = rect.minX, y = rect.minY, w = rect.width, h = rect.height
        
        path.move(to: CGPoint(x: x + cutLength, y: y))
        path.addLine(to: CGPoint(x: x + w - cutLength, y: y))
        path.addLine(to: CGPoint(x: x + w, y: y + cutLength))
        path.addLine(to: CGPoint(x: x + w, y: y + h - cutLength))
        path.addLine(to: CGPoint(x: x + w - cutLength, y: y + h))
        path.addLine(to: CGPoint(x: x + cutLength, y: y + h))
        path.addLine(to: CGPoint(x: x, y: y + h - cutLength))
        path.addLine(to: CGPoint(x: x, y: y + cutLength))
        path.closeSubpath()
        
        return path
    }
}

struct OctagonButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.neoDunggeunmo(size: 16))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
        }
        .frame(width: 303, height: 50)
        .background(Color.black)
        .clipShape(OctagonShape())
        .padding()
    }
}
