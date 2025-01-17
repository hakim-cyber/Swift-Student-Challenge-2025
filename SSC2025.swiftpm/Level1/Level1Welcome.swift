//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/5/25.
//

import SwiftUI

struct Level1WelcomeView: View {
    @State private var uiscreen = UIScreen.main.bounds
    var next:()->Void
    var body: some View {
        
        VStack(spacing: 25) {
            VStack {
                Text("Welcome")
                    .font(.system(size: 25, weight: .black, design: .monospaced))
                    .foregroundStyle(Color.white)
                Text("Cipher Master!")
                    .font(.system(size: 25, weight: .black, design: .monospaced))
                    .foregroundStyle(Color.cyan)
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("The keynote is locked with an encrypted password.")
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.leading)
                
                Text("Decode the Caesar Cipher, unlock the folder, and send it to Steve’s assistant.")
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundStyle(.cyan)
                    .multilineTextAlignment(.leading)
            }
            .padding()
            Spacer()
            Text("Time is ticking—WWDC depends on you!")
                .font(.system(size: 18, weight: .black, design: .monospaced))
                .foregroundStyle(.red)
                .multilineTextAlignment(.leading)
            
            AnimatedButtonMeshGradient(text: "Start") {
                next()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .padding(.top, 20)
       
    }
}

#Preview {
    Level1WelcomeView{
        
    }
}
