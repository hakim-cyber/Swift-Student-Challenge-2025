//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/5/25.
//

import SwiftUI

struct Level1Main: View {
    let original = "WKH SDVVZRUG LV: 5IF@ZZGF"
  
    @State private var encryptedText:String = "WKH SDVVZRUG LV: 5IF@ZZGF"
    @State private var solved:Bool = false
    @State private var shift = 0.0
    
    @State private var selectedHint:Int? = nil
    
    let size :CGSize
    var next:()->Void
    var back:()->Void
    var body: some View {
        
        ScrollView(.vertical){
            VStack(spacing: 15){
                HStack{
                    Button{
                        back()
                    }label: {
                        Image(systemName: "arrow.backward")
                            .bold()
                            .foregroundStyle(.white)
                    }
                    Spacer()
                }
                VStack(spacing: 25){
                    VStack(alignment: .leading,spacing: 10){
                        Text("Encrypted Message from Hackers:")
                            .font(.system(size: 18, weight: .black, design: .monospaced))
                            .foregroundStyle(Color.white)
                        Text("Hint:“In Caesar Cipher, letters are shifted by a fixed number. Try adjusting the slider!”")
                            .font(.system(size: 14, weight:.regular, design: .monospaced))
                            .foregroundStyle(Color.white)
                        
                    }
                    
                    HackerTextView(text: encryptedText, trigger: false,transition:.identity, speed: 0.01)
                    
                        .font(.system(size: 18, weight: solved ? .black : .bold, design: .monospaced))
                        .foregroundStyle(Color.white)
                    
                    
                        .padding()
                    
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(solved ? Color.cyan : Color.red,lineWidth: 3)
                        }
                    
                    VStack(){
                        Text("Shift:\(Int(shift))")
                            .font(.system(size: 18, weight: .bold, design: .monospaced))
                            .foregroundStyle(Color.white)
                        Slider(value: $shift, in: 0...10,step:1)
                            .tint(solved ? Color.cyan : Color.red)
                            .onChange(of: shift) {old,newValue in
                                if shift == 0{
                                    self.encryptedText = original
                                }else{
                                    let newString = caesar(text: original, shift: Int(-newValue))
                                    self.encryptedText = newString
                                    print(newString)
                                }
                                if shift == 3{
                                    self.solved = true
                                }else{
                                    self.solved = false
                                }
                            }
                            .frame(width: size.width / 4)
                        
                    }
                    if solved{
                        //                            Button{
                        //                                UIPasteboard.general.string = "5FC@WWDC"
                        //                                next()
                        //                            }label: {
                        //                                HStack{
                        //                                    Text("Copy Password")
                        //                                        .font(.system(size: 18, weight: .bold, design: .default))
                        //                                        .foregroundStyle(Color.white)
                        //                                        .multilineTextAlignment(.leading)
                        //                                }
                        //                                .padding(8)
                        //                                .padding(.horizontal,40)
                        //                                .background(Color.cyan)
                        //                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        //
                        //                            }
                        AnimatedButtonMeshGradient(text: "Copy Password", image: Image(systemName: "document.on.document.fill"), action: {
                            UIPasteboard.general.string = "5FC@WWDC"
                            next()
                        })
                        .transition(.opacity)
                    }
                    hintView(index: 1, hint: "The key to decoding lies in the number '3.' Adjust the slider and watch the encrypted message transform!")
                    Color.clear.frame(height: 50)
                }
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .padding()
            .padding(.top,20)
            .particleEffect(systemImage: "star.fill", font: .largeTitle, status: solved, activeTint: .yellow, inactiveTint: .secondary)
        }
        
    }
    @ViewBuilder
    func hintView(index:Int,hint:String) -> some View {
        VStack(spacing:15){
            
            VStack(alignment:.leading, spacing:10){
                HStack{
                    Image(systemName: "lightbulb.min.fill")
                        .foregroundStyle(.yellow)
                    
                    Text("Hint \(index)")
                    
                    Spacer()
                    if self.selectedHint    != index {
                        Image(systemName: "chevron.down")
                            .foregroundStyle(.secondary)
                    }else{
                        Image(systemName: "chevron.up")
                            .foregroundStyle(.secondary)
                    }
                }
                .fontWeight(.black)
                .padding(.horizontal,20)
                if self.selectedHint    == index {
                    Text(hint)
                        .multilineTextAlignment(.leading)
                        .fontWeight(.black)
                        .padding(.horizontal,20)
                       
                }
               
            }
            Divider()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.2)){
                if self.selectedHint == index {
                    selectedHint = nil
                }else{
                    selectedHint = index
                }
            }
        }
    }
    func caesar(text: String, shift: Int) -> String {
        // Normalize the shift to be within the range of 0-25
        // Helper function to shift a single character
        func shiftCharacter(_ char: Character, by shift: Int) -> Character {
            guard let asciiValue = char.asciiValue else { return char } // Non-alphabetic characters are returned as-is
            
            let isUppercase = char.isUppercase
            let baseAscii: UInt8 = isUppercase ? 65 : 97 // 'A' or 'a'
            let alphabetCount = 26
            
            // Normalize shift to a positive value within range
            let effectiveShift = (shift % alphabetCount + alphabetCount) % alphabetCount
            
            // Calculate the new ASCII value
            if char.isLetter {
                let newAsciiValue = baseAscii + (asciiValue - baseAscii + UInt8(effectiveShift)) % UInt8(alphabetCount)
                return Character(UnicodeScalar(newAsciiValue))
            }
            
            return char // Return non-alphabetic characters unchanged
        }
        
        // Process each character in the text
        let shiftedText = text.map { shiftCharacter($0, by: shift) }
        return String(shiftedText)
    }
}


