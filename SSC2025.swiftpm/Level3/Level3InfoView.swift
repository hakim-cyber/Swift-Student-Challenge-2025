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
        
            VStack(spacing: 25){
                VStack{
                    Text("Level 3")
                        .font(.system(size: 25, weight: .black, design: .monospaced))
                        .foregroundStyle(Color.white)
                    Text("Recovering the Backup Key")
                        .font(.system(size: 25, weight: .black, design: .monospaced))
                        .foregroundStyle(Color.cyan)
                }
                VStack(alignment:.leading, spacing:20){
                    Text("""
                         The Axicle system’s backup key has been hidden and corrupted. Your mission is to recover the key by decoding an encrypted message using the Atbash cipher. Once you have the key, you’ll use it to secure Axicle and restore the system.
                         """)
                    
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundStyle(Color.white)
                        .multilineTextAlignment(.leading)
                       
                    
                    Text("""
                        Here’s what you need to do:
                         1.    Solve the Atbash Cipher: You’ll be given an encrypted message.
                         2.    Secure Axicle: After decoding the key, use it to secure the Axicle system.
                        """)
                        .font(.system(size: 17, weight: .bold, design: .monospaced))
                        .foregroundStyle(.cyan)
                        .multilineTextAlignment(.leading)
                   
                }
                .padding()
                
                Text("You’ve got this! Let’s get the system back online.")
                    .font(.system(size: 18, weight: .black, design: .monospaced))
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.leading)
                
                AnimatedButtonMeshGradient(text: "Start") {
                    next()
                }
                .padding(.top)
               
                
                
               
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .padding()
            .padding(.top,20)
       
    }
}

#Preview {
    let size = UIScreen.main.bounds.size
    Level3InfoView{
        
    }
        .modifier(MacBackgroundStyle(size:.init(width:size.width / 1.5,height: size.height / 1.5)){
         
        })
}
