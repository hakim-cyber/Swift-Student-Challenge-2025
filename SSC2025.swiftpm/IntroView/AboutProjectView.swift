//
//  AboutProjectView.swift
//  SSC2025
//
//  Created by aplle on 1/21/25.
//

import SwiftUI
struct AboutProjectView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("About Cipher Master")
                    .font(.title2)
                    .fontWeight(.black)
                
                Text("""
                Cipher Master is an exciting game that combines cryptography and storytelling to teach players about classic ciphers like Caesar, Atbash, Vigenère, and Morse code. The objective is to solve challenges and progress through a thrilling storyline.
                """)
                .bold()
                .font(.title3)
                
                Text("Unlock new skills and save WWDC!")
                    .foregroundStyle(.cyan)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Divider()
                
                Text("About the Developer")
                    .font(.title2)
                    .fontWeight(.black)
                
                Text("Cipher Master was crafted with love by Hakim Aliyev, an 18-year-old developer")
                    .bold()
                    .font(.title3)
            }
            .fontDesign(.monospaced)
            .padding()
        }
    }
}
#Preview {
    AboutProjectView()
}
