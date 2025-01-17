//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/11/25.
//

import SwiftUI

struct Level4InfoView: View {
    var next:()->Void
    var body: some View {
        VStack(spacing: 25) {
            VStack {
                Text("Level 4")
                    .font(.system(size: 25, weight: .black, design: .monospaced))
                    .foregroundStyle(Color.white)
                Text("Unlock the Wi-Fi")
                    .font(.system(size: 25, weight: .black, design: .monospaced))
                    .foregroundStyle(Color.cyan)
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Text("""
                    Final mission! Hackers encrypted the Wi-Fi password needed for the WWDC stream. Decode it using the Vigenère cipher to unlock exclusive content.
                    """)
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundStyle(Color.white)

                Text("""
                    Steps:
                    1. Decrypt the password using the cipher key.
                    2. Connect to Wi-Fi and restore the stream.
                    """)
                    .font(.system(size: 17, weight: .bold, design: .monospaced))
                    .foregroundStyle(Color.cyan)
            }
            .padding()

            Text("Need help? Hints are available. The key phrase is closer than you think.")
                .font(.system(size: 18, weight: .black, design: .monospaced))
                .foregroundStyle(.red)

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
    Level4InfoView{
        
    }
}
