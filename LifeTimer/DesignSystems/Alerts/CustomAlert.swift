//
//  CustomAlert.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/6/25.
//

import SwiftUI

struct CustomAlert: View {
    let title: String
    let confirmAction: () -> Void
    let cancelAction: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.neoDunggeunmo(size: 18))
                .foregroundColor(.black)
                .padding(.leading, 15)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 0) {
                Button(action: cancelAction) {
                    Text("아니요")
                        .font(.neoDunggeunmo(size: 18))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .background(Color.white)
                .overlay(Rectangle().stroke(Color.black, lineWidth: 1))
                
                Button(action: confirmAction) {
                    Text("예")
                        .font(.neoDunggeunmo(size: 18))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .background(Color.white)
                .overlay(Rectangle().stroke(Color.black, lineWidth: 1))
            }
        }
        .padding()
        .background(Color.white)
        .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
        .cornerRadius(0)
        .frame(maxWidth: 300)
    }
}
