//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/5/25.
//

import SwiftUI

struct FlyingBirdButton: View {
    @State private var isFlying = false
    @State private var showButton = true
    var action:()->Void
    var body: some View {
        ZStack {
            if showButton {
                AnimatedButtonMeshGradient(text: "Send", image:  Image(systemName: "airplane")) {
                    isFlying.toggle()
                                       action()
                }

            }
            
            if isFlying {
                BirdAnimationView {
               
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        isFlying = false
                        showButton = true
                    }
                }
            }
        }
        .animation(.easeInOut, value: isFlying)
        .audioPlayer(audioName: "fly", audioExtension: "m4a", trigger: $isFlying)
    }
}

struct BirdAnimationView: View {
    let onAnimationComplete: () -> Void
    @State private var flyOffset = CGSize.zero
    @State private var rotationAngle: Double = 0
    var body: some View {
        Image(systemName: "airplane")
            
                   .resizable()
                   .scaledToFit()
                   .frame(width: 50, height: 50)
                   .foregroundColor(.cyan)
                  
                   .offset(flyOffset)
                   .rotationEffect(.degrees(rotationAngle))
                   .rotation3DEffect(.degrees(rotationAngle), axis: (x: 1, y: 0, z: 0))
                   .onAppear {
                       withAnimation(.bouncy(duration: 2.5)) {
                           
                           flyOffset = CGSize(width: UIScreen.main.bounds.width, height: -UIScreen.main.bounds.height / 3)
                           rotationAngle = -30 
                       }

                      
                       DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                           flyOffset = .zero
                           rotationAngle = 0
                           onAnimationComplete()
                       }
                   }
    }
}

struct FlyingBirdButton_Previews: PreviewProvider {
    static var previews: some View {
        FlyingBirdButton{
            
        }
    }
}
