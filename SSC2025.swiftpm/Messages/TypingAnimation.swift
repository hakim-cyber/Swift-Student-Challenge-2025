//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/16/25.
//

import SwiftUI

struct TypingAnimation: View {
    @State private var isAnimating = true

    var body: some View {
        HStack {
            HStack(spacing: 8) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 6, height: 6)
                        .scaleEffect(isAnimating ? 1.2 : 1.0) // Scale effect animation
                        .animation(
                            .easeInOut(duration: 0.5)
                                .repeatForever()
                                .delay(Double(index) * 0.2),
                            value: isAnimating
                        )
                        
                }
            }
            .padding(15)
            .background(
                BubbleShape(myMessage: false)
                    .fill(Color(uiColor: .systemGray4))
            )
            .onAppear {
                isAnimating = false // Starts the animation when the view appears
            }

            Spacer() // Keeps the typing animation aligned to the left
        }
        
        .padding(.horizontal)
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .center)
    }
}
#Preview {
    TypingAnimation()
}
