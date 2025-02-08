//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 2/8/25.
//

import SwiftUI
enum infoViewSteps:String,CaseIterable{
    case Caesar,MorseCode,Atbash,Vigenere
}
struct GameInfoView: View {
    let sizeOfScreen:CGSize
    var swipe:(()->Void)?
    var close:(()->Void)?
    @State private var selectedStep:infoViewSteps = .Caesar
    var body: some View {
        ZStack{
            GeometryReader{ geo in
                let size = geo.size
                HStack(spacing: 0) {
                    
                    
                    ScrollView(.vertical){
                        VStack(alignment:.leading, spacing:10){
                                           
                                           ForEach(infoViewSteps.allCases,id:\.rawValue) { step in
                                               ZStack{
                                                   RoundedRectangle(cornerRadius: 6)
                                                       .fill(selectedStep == step ? Color.gray.opacity(0.2) :Color.clear)
                                                       .padding(.horizontal,4)
                                                       .frame(width: size.width * 0.15)
                                                      
                                                       Button {
                                                           
                                                           self.selectedStep = step
                                                       } label: {
                                                           Text(step.rawValue)
                                                               .font(.subheadline)
                                                               .foregroundColor(.white)
                                                               .padding(.horizontal,5)
                                                              
                                                               .bold()
                                                               .padding(5)
                                                             
                                                               .multilineTextAlignment(.leading)
                                                               .padding(.horizontal,5)
                                                       }
                                                      
                                                       .frame(maxWidth: .infinity,alignment: .leading)
                                                       
                                                   
                                               }
                                               
                                             
                                           }
                                           Color.clear.frame(height: 100)
                                       }
                                       .padding(.top)
                                      
                                       
                                   }
                                  
                                       .frame(width: size.width * 0.16)
                                       .background(.thinMaterial)
                    Group{
                        switch selectedStep {
                        case .Caesar:
                            caesar
                            
                        case .MorseCode:
                            morseCode
                        case .Atbash:
                            atbashView
                        case .Vigenere:
                            vigenere
                        }
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
                    
                    
                }
                
            }
          
            
            
          
            
        }
        .modifier(MacBackgroundStyle(size: .init(width: sizeOfScreen.width / 1.5, height: sizeOfScreen.height / 2), title: "About Chiphres", swipe: {
            swipe?()
        }, close: {
            close?()
        }))
    }
    var caesar:some View{
        VStack(alignment: .leading, spacing: 12) {
                    Text("🔢 Caesar Cipher")
                        .font(.title2).bold()
                    
                    Text("Each letter shifts forward by a set number. If the shift is **+3**:")
                        .font(.body)
                    
                    Text("🔸 H → K   E → H   L → O   L → O   O → R")
                        .font(.system(.body, design: .monospaced))
                        .padding(.vertical, 4)
                    
                    Text("➡️ **KHOOR**")
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    Text("To decode, shift backward by the same number.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding()
    }
    var vigenere:some View{
        VStack(alignment: .leading, spacing: 12) {
                    Text("🔑 Vigenère Cipher")
                        .font(.title2).bold()
                    
                    Text("Uses a **secret word (key)** to shift letters differently.")
                        .font(.body)
                    
                    Text("Key: **KEY** → K(+10), E(+4), Y(+24)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    Text("🔸 H → R   E → I   L → J   L → V   O → S")
                        .font(.system(.body, design: .monospaced))
                        .padding(.vertical, 4)
                    
                    Text("➡️ **RIJVS**")
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    Text("To decrypt, you **must find the key**!")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding()
    }
    var morseCode:some View{
        VStack(alignment: .leading, spacing: 12) {
                    Text("📡 Morse Code")
                        .font(.title2).bold()
                    
                    Text("Represents letters as short and long signals (dots and dashes).")
                        .font(.body)
                    
                    Text("🔸 H = ....   E = .   L = .-..   L = .-..   O = ---")
                        .font(.system(.body, design: .monospaced))
                        .padding(.vertical, 4)
                    
                    Text("➡️ **.... . .-.. .-.. ---**")
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    Text("Used in **radio, flashing lights, and telegraphs**.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding()
    }
    var atbashView:some View{
        VStack(alignment: .leading, spacing: 12) {
                    Text("🔄 Atbash Cipher")
                        .font(.title2).bold()
                    
                    Text("A simple cipher where each letter is replaced by its opposite in the alphabet (A = Z, B = Y, etc.).")
                        .font(.body)
                    
                    Text("🔸 H → S   E → V   L → O   L → O   O → L")
                        .font(.system(.body, design: .monospaced))
                        .padding(.vertical, 4)
                    
                    Text("➡️ **SVOOL**")
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    Text("Encrypting and decrypting are the **same process**!")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding()
    }
}

#Preview {
    GameInfoView(sizeOfScreen: UIScreen.main.bounds.size)
}
