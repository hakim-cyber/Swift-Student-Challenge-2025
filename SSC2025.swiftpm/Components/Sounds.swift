//
//  File.swift
//  SSC2025
//
//  Created by aplle on 1/9/25.
//

import SwiftUI
import AVFoundation

struct AudioPlayerForView: ViewModifier {
    @State private var audioPlayer: AVAudioPlayer?
    @Binding var trigger: Bool
    let audioName: String
    let audioExtension: String

    func body(content: Content) -> some View {
        content
            .onAppear(perform: {
                if trigger {
                    playSound()
                    // Reset the trigger to false after playing the sound
                    DispatchQueue.main.async {
                        trigger = false
                    }
                }
            })
            .onChange(of: trigger) { _, newValue in
                if newValue {
                    playSound()
                    // Reset the trigger to false after playing the sound
                    DispatchQueue.main.async {
                        trigger = false
                    }
                }
            }
    }

    private func playSound() {
        guard let soundURL = Bundle.main.url(forResource: audioName, withExtension: audioExtension) else {
            print("Sound file \(audioName).\(audioExtension) not found.")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}

extension View {
    func audioPlayer(audioName: String, audioExtension: String, trigger: Binding<Bool>) -> some View {
        self.modifier(AudioPlayerForView(trigger: trigger, audioName: audioName, audioExtension: audioExtension))
    }
}
