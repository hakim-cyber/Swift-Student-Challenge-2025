//
//  File.swift
//  SSC2025
//
//  Created by aplle on 1/11/25.
//

import SwiftUI
import AVFoundation
import AVFoundation

struct AudioPlayer2: ViewModifier {
    
    @State private var audioPlayer: AVAudioPlayer?
    @State private var audioTimer: Timer?
    @Binding var trigger: Bool
    let audioName: String
    let audioExtension: String

    func body(content: Content) -> some View {
        content
          
            .onChange(of: trigger) { _, newValue in
                if newValue {
                    playSound()
                    
                } else {
                    stopSound()
                }
            }
    }

    private func playSound() {
        guard let soundURL = Bundle.main.url(forResource: audioName, withExtension: audioExtension) else {
            print("Sound file \(audioName).\(audioExtension) not found.")
            return
        }
        
        do {
           
            audioPlayer?.stop()
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
          
            startAudioTimer()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    private func stopSound() {
        audioPlayer?.stop()
        audioPlayer = nil
        audioTimer?.invalidate()
        audioTimer = nil
        self.trigger = false
    }

    private func startAudioTimer() {
       
        audioTimer?.invalidate()
        
        
        audioTimer = Timer.scheduledTimer(withTimeInterval: audioPlayer?.duration ?? 0, repeats: false) { _ in
           
            stopSound()
        }
    }
}

extension View {
    func audioPlayer2(audioName: String, audioExtension: String, trigger: Binding<Bool>) -> some View {
        self.modifier(AudioPlayer2(trigger: trigger, audioName: audioName, audioExtension: audioExtension))
    }
}
