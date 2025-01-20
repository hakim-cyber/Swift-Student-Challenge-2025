//
//  AboutCiphersView.swift
//  SSC2025
//
//  Created by aplle on 1/21/25.
//
import SwiftUI

struct AboutCiphersView: View {
    @State private var selectedChiphre:ChiphreType = .caesarCipher
    @State private var original: String = ""
    var body: some View {
        GeometryReader { geometry in
            
            
            ScrollView {
                VStack(alignment: .center, spacing: 15) {
                    Text("About Cipher Master")
                        .font(.title2)
                        .fontWeight(.black)
                    
                    Text("""
                - **Caesar Cipher**: Letters are shifted by a fixed number.
                - **Atbash Cipher**: Letters are replaced with their reverse counterparts.
                - **Vigenère Cipher**: A more complex cipher using a key phrase.
                - **Morse Code**: A code consisting of dots and dashes.
                """)
                    .bold()
                    .font(.title3)
                    
                    HStack{
                        Spacer()
                        Picker("Select Chipher", selection: $selectedChiphre) {
                            ForEach(ChiphreType.allCases,id:\.rawValue){type in
                                Text(type.description)
                                    .textCase(.uppercase)
                                    .tag(type)
                            }
                        }
                        Spacer()
                    }
                    Group{
                        switch selectedChiphre {
                        case .caesarCipher:
                            CaesarChiphreDemoView(original: $original)
                        case .atbashCipher:
                            AtbashChiphreDemoView(original: $original)
                        case .vigenèreCipher:
                            VigenereChiphreDemoView(original: $original)
                        case .morseCode:
                            MorseCodeDemoView(original: $original)
                        }
                    }
                    .frame(width: geometry.size.width / 2)
                }
                .fontDesign(.monospaced)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .center)
            }
           
        }
       
    }
}
#Preview{
    AboutCiphersView()
        .frame(width: UIScreen.main.bounds.width / 2)
}

enum ChiphreType: String, CaseIterable {
    case caesarCipher
    case atbashCipher
    case vigenèreCipher
    case morseCode
    
    var description: String {
        switch self {
        case .caesarCipher: return "Caesar Cipher"
        case .atbashCipher: return "Atbash Cipher"
        case .vigenèreCipher: return "Vigenère Cipher"
        case .morseCode: return "Morse Code"
        }
    }
}

struct CaesarChiphreDemoView:View {
    @Binding var original: String
    @State private var encryptedText: String = ""
    @State private var shift: Double = 0
   
    var body: some View {
        VStack(alignment:.center,spacing: 45){
            TextField("Enter Text to Encrypt",text: $original)
                .font(.system(size: 18, weight: .black , design: .monospaced))
                .foregroundStyle(Color.white)
            
            
                .padding()
            
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke( Color.cyan ,lineWidth: 3)
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .onChange(of: original) {old,newValue in
                    self.encryptedText = caesarEncrypt(text: newValue, shift: Int(shift))
                }
            VStack(){
                Text("Shift:\(Int(shift))")
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                    .foregroundStyle(Color.white)
                Slider(value: $shift, in: 0...10,step:1)
                    .controlSize(.extraLarge)
                    .tint( Color.cyan)
                    .onChange(of: shift) { oldValue, newValue in
                                if newValue == 0 {
                                    self.encryptedText = original // Reset to original if shift is 0
                                } else {
                                    // Encrypt using the caesarEncrypt function (negative shift for encryption)
                                    let newString = caesarEncrypt(text: original, shift: Int(newValue))
                                    self.encryptedText = newString
                                    print(newString) // Print the encrypted string to the console
                                }
                            }
                
                
            }
            .contentShape(Rectangle())
            HackerTextView(text: encryptedText, trigger: false,transition:.identity, speed: 0.01)
            
                .font(.system(size: 18, weight: .black , design: .monospaced))
                .foregroundStyle(Color.white)
              
            
                .padding()
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke( Color.cyan ,lineWidth: 3)
                }
               
        }
        .padding()
        .onAppear {
            self.encryptedText = caesarEncrypt(text: original, shift: Int(shift))
        }
        
    }
    func caesarEncrypt(text: String, shift: Int) -> String {
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



struct MorseCodeDemoView:View {
    @Binding var original: String
    @State private var encryptedText: String = ""
    @StateObject var morseManager = MorseCodeConverter()
    var body: some View {
        VStack(alignment:.center,spacing: 45){
            TextField("Enter Text to Encrypt",text: $original)
                .font(.system(size: 18, weight: .black , design: .monospaced))
                .foregroundStyle(Color.white)
            
            
                .padding()
            
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke( Color.cyan ,lineWidth: 3)
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .onChange(of: original) { oldValue, newValue in
                    let morseText = morseManager.textToMorseCode(newValue)
                    self.encryptedText = morseText
                }
            
               
                    morseCodeText
                   
                    
                    
                
            
               
        }
        .padding()
        .onAppear {
            let morseText = morseManager.textToMorseCode(original)
            self.encryptedText = morseText
        }
    }
        var morseCodeText:some View{
            HStack{
                            if !self.encryptedText.isEmpty{
                                if morseManager.isPlaying{
                                    Image(systemName: "speaker.wave.3.fill")
                                        .foregroundStyle(Color.cyan)
                                }else{
                                    Image(systemName: "speaker.fill")
                                        .foregroundStyle(Color.cyan)
                                }
                            }
                            Text(encryptedText)
                            Spacer()
                        }
                            .font(.system(size: 18, weight:  .black, design: .monospaced))
                                                       .foregroundStyle(Color.white)
                                                       .lineSpacing(20)
                                                       .multilineTextAlignment(.leading)
                                                       .lineLimit(nil) // Allow unlimited lines
                                                                       .fixedSize(horizontal: false, vertical: true)
                                                       .padding()
                                                       .frame(maxWidth: .infinity)
                                                       .clipShape(RoundedRectangle(cornerRadius: 10))
                                                       .overlay{
                                                           RoundedRectangle(cornerRadius: 10)
                                                               .stroke(Color.cyan,lineWidth: 3)
                                                       }
                                                       .contentShape(Rectangle())
                                                       .onTapGesture {
                                                           // make sound of morse code
                                                           soundofMorseCode()
                                                       }
        }
    func soundofMorseCode(){
      
        morseManager.playMorseCode(self.removeWordSpace(from: encryptedText)){
            
        }
    }
    func removeWordSpace(from morseCode: String) -> String {
            // Removing the "/" character used to represent space between words in Morse code
            return morseCode.replacingOccurrences(of: "/", with: "")
        }
}

struct AtbashChiphreDemoView:View {
    @Binding var original: String
       @State private var encryptedText: String = ""
      
     
    var body: some View {
        VStack(alignment:.center,spacing: 45){
            TextField("Enter Text to Encrypt",text: $original)
                .font(.system(size: 18, weight: .black , design: .monospaced))
                .foregroundStyle(Color.white)
            
            
                .padding()
            
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke( Color.cyan ,lineWidth: 3)
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .onChange(of: original) {old,newValue in
                    let newtext = atbashCipherEncrypt(newValue)
                    self.encryptedText = newtext
                }
            
            HackerTextView(text: encryptedText, trigger: false,transition:.identity, speed: 0.01)
            
                .font(.system(size: 18, weight: .black , design: .monospaced))
                .foregroundStyle(Color.white)
            
            
                .padding()
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke( Color.cyan ,lineWidth: 3)
                }
            
        }
        .padding()
        .onAppear {
            let newtext = atbashCipherEncrypt(original)
            self.encryptedText = newtext
        }
     
    }
    func atbashCipherEncrypt(_ text: String) -> String {
        var encryptedText = ""
        
        for char in text {
            if let asciiValue = char.asciiValue {
                if char.isLowercase {
                    // Encrypt lowercase letters (a-z)
                    let newChar = Character(UnicodeScalar(219 - asciiValue)) // 219 = 'a' + 'z'
                    encryptedText.append(newChar)
                } else if char.isUppercase {
                    // Encrypt uppercase letters (A-Z)
                    let newChar = Character(UnicodeScalar(155 - asciiValue)) // 155 = 'A' + 'Z'
                    encryptedText.append(newChar)
                } else {
                    // Non-alphabetic characters are added as-is
                    encryptedText.append(char)
                }
            } else {
                encryptedText.append(char)
            }
        }
        
        return encryptedText
    }
}
struct VigenereChiphreDemoView:View {
    @Binding var original: String
       @State private var encryptedText: String = ""
      
    @State private var keyInput:String = ""
    var body: some View {
        VStack(alignment:.center,spacing: 45){
            TextField("Enter Text to Encrypt",text: $original)
                .font(.system(size: 18, weight: .black , design: .monospaced))
                .foregroundStyle(Color.white)
            
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke( Color.cyan ,lineWidth: 3)
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            TextField("Enter Key",text: $keyInput)
                .font(.system(size: 18, weight: .black , design: .monospaced))
                .foregroundStyle(Color.white)
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke( Color.cyan ,lineWidth: 3)
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
               
            
            HackerTextView(text: encryptText(text: original,key: keyInput), trigger: false,transition:.identity, speed: 0.01)
            
                .font(.system(size: 18, weight: .black , design: .monospaced))
                .foregroundStyle(Color.white)
            
            
                .padding()
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke( Color.cyan ,lineWidth: 3)
                }
            
        }
        .padding()
    
        
    }
    func encryptText(text: String,key: String) -> String {
        let newKey = key.trimAllSpace()
         
        
        if !newKey.isEmpty{
            let vigenere = Vigenere(key: newKey)
            let newText =   vigenere.encrypt(plainText: text)
            return newText
        }else{
           
          return text
        }
    }
    
}
