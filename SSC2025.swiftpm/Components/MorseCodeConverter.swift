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
    // Function to play Morse code sounds
    func playMorseCode(_ morseCode: String, finish: @escaping () -> Void) {
            if isPlaying {
                stopSound() // Stop the sound if it's already playing
                finish()
                return
            }

            isPlaying = true // Set playing flag to true
            
            let morseCharacters = morseCode.split(separator: " ")
            
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.7) {
                for (index, symbol) in morseCharacters.enumerated() {
                    if !self.isPlaying { break } // Stop if playback is stopped
                    
                    // Play the sound for the symbol
                    for morseSymbol in symbol {
                        if !self.isPlaying { break }
                        switch morseSymbol {
                        case ".":
                            self.playDotSound() // Play short sound for dot
                        case "-":
                            self.playDashSound() // Play long sound for dash
                        default:
                            continue
                        }
                    }

                    // Add a short pause between letters
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
    
    // Function to play the sound for a dot (short beep)
    private func playDotSound() {
        playSound(for: 0.2) // Short sound duration
    }
    
    // Function to play the sound for a dash (long beep)
    private func playDashSound() {
        playSound(for: 0.6) // Longer sound duration
    }
    
    // Function to play the sound for a letter space (short silence)
    private func playLetterSpaceSound() {
        Thread.sleep(forTimeInterval: 0.3) // Short pause between letters
    }
    
    // Function to play the sound for a word space (long silence)
    private func playWordSpaceSound() {
        Thread.sleep(forTimeInterval: 0.7) // Longer pause between words
    }
    
    // Function to play sound with a specific duration
    private func playSound(for duration: TimeInterval) {
        guard let soundURL = Bundle.main.url(forResource: "beep", withExtension: "mp3") else {
            print("Sound file not found.")
            return
        }
        
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
            // Pause for the duration of the sound
            Thread.sleep(forTimeInterval: duration)
            audioPlayer?.stop()
        } catch {
//            print("Error playing sound: \(error)")
        }
    }
    private func stopSound() {
            isPlaying = false
            audioPlayer?.stop()
        }
}
