//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/21/25.
//

import SwiftUI

struct IntroView: View {
    var start:()->Void
    var body: some View {
        NavigationView {
                    List {
                        Section(header: Text("About the Project").font(.headline)) {
                                           NavigationLink(destination: AboutProjectView()) {
                                               Label("What is Cipher Master?", systemImage: "info.circle")
                                           }
                            NavigationLink(destination: AboutCiphersView()) {
                                               Label("Learn About Ciphers", systemImage: "key")
                                           }
                                          
                                       }
                        Section(header:  Text("Game").font(.headline)) {
                            NavigationLink(destination: StartGameView(start: start)) {
                                               HStack {
                                                   Image(systemName: "play.circle")
                                                       .foregroundColor(.green)
                                                       .font(.system(size: 24))
                                                   Text("Start Game")
                                                       .font(.headline)
                                                       .foregroundColor(.primary)
                                               }
                                           }
                                       }
                }
                    .fontDesign(.monospaced)
            }
    }
}

#Preview {
    IntroView{
        
    }
}
