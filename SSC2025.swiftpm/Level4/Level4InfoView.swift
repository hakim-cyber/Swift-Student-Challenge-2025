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
                    This is your final mission! Hackers have encrypted the Wi-Fi password needed to watch WWDC, and it’s up to you to crack it.
                    There’s something exclusive waiting for you in the stream, but first, you need to decode the password using the Vigenère cipher.
                    """)
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.leading)

                Text("""
                    Here’s what you need to do:
                    1. Solve the Cipher: Decrypt the password with the key.
                    2. Connect to Wi-Fi: Use the password to restore the connection and watch the stream.
                    """)
                    .font(.system(size: 17, weight: .bold, design: .monospaced))
                    .foregroundStyle(.cyan)
                    .multilineTextAlignment(.leading)
            }
            .padding()

            Text("Hints are available if you need them. The key phrase is closer than you think.")
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
    Level4InfoView{
        
    }
}
