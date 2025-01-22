//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/21/25.
//

import SwiftUI

struct StartGameView: View {
    var start: () -> Void
        var body: some View {
            VStack(spacing: 20) {
                Text("🕵️ Tips for Cipher Master")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.cyan)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("1. Use hints wisely to go faster through Cipher Master and save WWDC!")
                        .font(.title2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .fontWeight(.bold)
                }
                .padding(.top, 10)
                
                Spacer()
                
                Button(action: {
                   
                    start()
                }) {
                    Text("Start the Game")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.cyan)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .padding()
            }
            .fontDesign(.monospaced)
            .padding()
           
            .navigationTitle("Start Game")
        }
}

#Preview {
    StartGameView{
        
    }
}
