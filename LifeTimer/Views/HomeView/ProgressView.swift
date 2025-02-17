//
//  ProgressView.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/5/25.
//

import SwiftUI

struct ProgressView: View {
    let progress: Double
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Rectangle()
                    .stroke(Color.black, lineWidth: 2)
                    .background(
                        Rectangle()
                            .fill(Color.white)
                    )
                
                Rectangle()
                    .fill(Color.black)
                    .frame(width: geo.size.width * CGFloat(progress))
                
                if progress > 0 {
                    Image("runner")
                        .resizable()
                        .frame(width: 50, height: 40)
                        .offset(
                            x: geo.size.width * CGFloat(progress) - 25,
                            y: -40 // Half the height of the progress bar
                        )
                }
            }
        }
        .frame(height: 15)
    }
}
