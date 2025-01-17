//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/11/25.
//

import SwiftUI

struct ShiningText: View {
    let text: String
    // For the animation effect
       
       var body: some View {
           Text(text)
               .font(.headline) // Choose a suitable font size/style
               .modifier(ShiningEffect())
               .padding(.leading,10)
       }
}

struct ShiningEffect:ViewModifier {
    var systemColor:Color = .yellow
    var shadowColor:Color = .yellow
    var shine:Bool = true
    @State private var glow = false
    func body(content: Content) -> some View {
        if shine{
            content
                .foregroundColor(systemColor)
                .shadow(color: shadowColor, radius: glow ? 10 : 5) // Glow effect
                .scaleEffect(glow ? 1.2 : 1) // Slightly grow/shrink text
                .animation(
                    Animation.easeInOut(duration: 1) // Smooth animation
                        .repeatForever(autoreverses: true),
                    value: glow
                )
                .onAppear {
                    glow = true // Start glowing when the view appears
                }
                
        }else{
            content
        }
    }
}
