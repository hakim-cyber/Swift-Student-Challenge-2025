//
//  File.swift
//  SSC2025
//
//  Created by aplle on 1/7/25.
//
import Foundation
import AVFoundation

class MorseCodeConverter:ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    
    private let morseCodeDictionary: [Character: String] = [
            "A": ".-", "B": "-...", "C": "-.-.", "D": "-..", "E": ".", "F": "..-.",
            "G": "--.", "H": "....", "I": "..", "J": ".---", "K": "-.-", "L": ".-..",
            "M": "--", "N": "-.", "O": "---", "P": ".--.", "Q": "--.-", "R": ".-.",
            "S": "...", "T": "-", "U": "..-", "V": "...-", "W": ".--", "X": "-..-",
            "Y": "-.--", "Z": "--..",
            
            "1": ".----", "2": "..---", "3": "...--", "4": "....-", "5": ".....",
            "6": "-....", "7": "--...", "8": "---..", "9": "----.", "0": "-----",
            
            ".": ".-.-.-", ",": "--..--", "?": "..--..", "'": ".----.", "!": "-.-.--",
            "/": "-..-.", "(": "-.--.", ")": "-.--.-", "&": ".-...", ":": "---...",
            ";": "-.-.-.", "=": "-...-", "-": "-....-", "_": "..--.-", "+": ".-.-.",
            "$": "...-..-", "@": ".--.-.", " ": "/"
        ]
    func textToMorseCode(_ text: String) -> String {
            let uppercasedText = text.uppercased()
            var morseCode = ""
            
            for char in uppercasedText {
                if let code = morseCodeDictionary[char] {
                    morseCode += code + " "
                }
            }
            
            return morseCode.trimmingCharacters(in: .whitespaces)
        }
        
   
    func playMorseCode(_ morseCode: String, finish: @escaping () -> Void) {
            if isPlaying {
                stopSound()
                finish()
                return
            }

            isPlaying = true
            
            let morseCharacters = morseCode.split(separator: " ")
            
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.7) {
                for (index, symbol) in morseCharacters.enumerated() {
                    if !self.isPlaying { break }
                    
                  
                    for morseSymbol in symbol {
                        if !self.isPlaying { break }
                        switch morseSymbol {
                        case ".":
                            self.playDotSound()
                        case "-":
                            self.playDashSound()
                        default:
                            continue
                        }
                    }

                    
                    if index < morseCharacters.count - 1 {
                        self.playWordSpaceSound()
                    }
                }
                
                DispatchQueue.main.async {
                    self.isPlaying = false
                    self.audioPlayer?.stop()
                    finish()
                }
            }
        }
    
   
    private func playDotSound() {
        playSound(for: 0.2)
    }
    
    
    private func playDashSound() {
        playSound(for: 0.6)
    }
    
    
    private func playLetterSpaceSound() {
        Thread.sleep(forTimeInterval: 0.3)
    }
    
  
    private func playWordSpaceSound() {
        Thread.sleep(forTimeInterval: 0.7)
    }
    
   
    private func playSound(for duration: TimeInterval) {
        guard let soundURL = Bundle.main.url(forResource: "beep", withExtension: "mp3") else {
            print("Sound file not found.")
            return
        }
        
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
            
            Thread.sleep(forTimeInterval: duration)
            audioPlayer?.stop()
        } catch {           
        }
    }
    private func stopSound() {
            isPlaying = false
            audioPlayer?.stop()
        }
}
