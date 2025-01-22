//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/8/25.
//

import SwiftUI

struct Level3InfoView: View {
    var next:()->Void
    var body: some View {
        
        VStack(spacing: 25) {
            VStack {
                Text("Level 3")
                    .font(.system(size: 25, weight: .black, design: .monospaced))
                    .foregroundStyle(Color.white)
                Text("Recover the Backup Key")
                    .font(.system(size: 25, weight: .black, design: .monospaced))
                    .foregroundStyle(Color.cyan)
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Text("""
                     The Axicle system’s backup key is corrupted and hidden. Decode the message using the Atbash Cipher to recover the key and secure Axicle.
                     """)
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundStyle(Color.white)
                
                Text("""
                     Steps to complete:
                     1. Solve the Atbash Cipher to find the key.
                     2. Use the key to secure the Axicle system.
                     """)
                    .font(.system(size: 17, weight: .bold, design: .monospaced))
                    .foregroundStyle(.cyan)
            }
            .padding()
            
            Text("You’ve got this! Let’s bring the system back online.")
                .font(.system(size: 18, weight: .black, design: .monospaced))
                .foregroundStyle(.red)
            
            AnimatedButtonMeshGradient(text: "Start") {
                next()
            }
            .padding(.top)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .padding(.top, 20)
       
    }
}

#Preview {
    let size = UIScreen.main.bounds.size
  return  Level3InfoView{
        
    }
        .modifier(MacBackgroundStyle(size:.init(width:size.width / 1.5,height: size.height / 1.5)){
         
        })
}
