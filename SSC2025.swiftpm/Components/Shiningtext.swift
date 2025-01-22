//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/11/25.
//

import SwiftUI

struct ShiningText: View {
    let text: String
    
       
       var body: some View {
           Text(text)
               .font(.headline)
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
                .shadow(color: shadowColor, radius: glow ? 10 : 5)
                .scaleEffect(glow ? 1.2 : 1)
                .animation(
                    Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: true),
                    value: glow
                )
                .onAppear {
                    glow = true 
                }
                
        }else{
            content
        }
    }
}
