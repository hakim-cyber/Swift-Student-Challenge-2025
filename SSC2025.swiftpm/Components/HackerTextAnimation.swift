//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/5/25.
//

import SwiftUI

struct HackerTextView: View {
    var text: String
    var trigger:Bool
    var transition: ContentTransition = .opacity
    var duration: CGFloat = 1.0
    var speed: CGFloat = 0.1
   

    @State private var animatedText: String = ""
    @State private var randomCharacters: [Character] = {
        let string = "abcdefghijklmnopqrstuvwxyz"
        return Array(string)
    }()

    
    var body: some View {
        Text(animatedText)
           
            .truncationMode(.tail)
            .contentTransition(transition)
            .animation(.easeInOut(duration: 0.1), value:animatedText)
            .onAppear{
                guard animatedText.isEmpty else{return}
                animatedText = text
            }
            .onChange(of: trigger) { oldValue, newValue in
                animateText()
            }
        
            .onChange(of: text) { oldValue, newValue in
                animatedText  = text
                setRandomCharacters()
                animateText()
            }
        
    }

    private func animateText(){
        for index in text.indices{
            let delay = CGFloat.random(in: 0...0.5)
            let timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { _ in
                guard let randomCharacter = randomCharacters.randomElement() else{return}
                replaceCharacter(at: index, character: randomCharacter)
            }
            timer.fire()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if text.indices.contains( index){
                    let actualCharacter = text[index]
                    replaceCharacter(at: index, character: actualCharacter)
                }
                timer.invalidate()
            }
        }
    }
   private func setRandomCharacters(){
       animatedText = text
       
       for index in animatedText.indices{
           guard let randomCharacter = randomCharacters.randomElement() else{return}
           replaceCharacter(at: index, character: randomCharacter)
       }
    }
    func replaceCharacter(at index:String.Index,character:Character){
        guard animatedText.indices.contains(index) else{return}
        let indexCharacter = String(animatedText[index])
        
        if indexCharacter.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
            animatedText.replaceSubrange(index...index, with: String(character))
        }
    
    }
}


