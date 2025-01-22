//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/11/25.
//

import SwiftUI


struct Level4DecryptView: View {
    let original = "Lail Rxvlwc, Jxnr Yvwysvp".uppercased()
    let password = "Stay Hungry, Stay Foolish".uppercased()
    @State private var encryptedText:String = "Lail Rxvlwc, Jxnr Yvwysvp".uppercased()
    
    @EnvironmentObject var level4Data: Level4Data
    
    @State private var keyInput:String = ""
    
    @State private var selectedHint:Int? = nil
    
    @State private var playSound:Bool = false
    let size :CGSize
    var body: some View {
        ScrollView(.vertical){
            VStack(spacing: 25){
                VStack(alignment: .leading,spacing: 10){
                    Text("Encrypted Password:")
                        .font(.system(size: 18, weight: .black, design: .monospaced))
                        .foregroundStyle(Color.white)
                    Text("Hint: “Find and use the key of Vigenere Chipher to decode wifi password ”")
                        .font(.system(size: 14, weight:.regular, design: .monospaced))
                        .foregroundStyle(Color.white)
                    
                }
                VStack(spacing: 25){
                    HackerTextView(text: encryptedText, trigger: false,transition:.identity, speed: 0.01)
                    
                        .font(.system(size: 18, weight: level4Data.solved  ? .black : .bold, design: .monospaced))
                        .foregroundStyle(Color.white)
                    
                    
                        .padding()
                    
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(level4Data.solved ? Color.cyan : Color.red,lineWidth: 3)
                        }
                    
                    Text("Enter Key:")
                        .font(.system(size: 18, weight: .bold, design: .monospaced))
                        .foregroundStyle(Color.white)
                    HStack{
                        TextField("Enter decryption key", text: $keyInput)
                            .padding()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .background(RoundedRectangle(cornerRadius: 20).fill(.regularMaterial))
                        
                            .foregroundStyle(Color.white)
                            .accentColor(.cyan)
                        
                            .frame(width: size.width / 2)
                            .onChange(of: keyInput) { oldValue, newValue in
                                let newKey = newValue.trimAllSpace()
                                 
                                
                                if !newKey.isEmpty{
                                    let vigenere = Vigenere(key: newKey)
                                    self.encryptedText =   vigenere.decrypt(encryptedText: original)
                                    if self.encryptedText == password{
                                        self.level4Data.solved = true
                                    }else{
                                        self.level4Data.solved = false
                                    }
                                }else{
                                    self.level4Data.solved = false
                                    self.encryptedText = original
                                }
                            }
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                        Button{
                            withAnimation(.bouncy){
                                if let paste = UIPasteboard.general.string{
                                    self.keyInput = paste
                                }
                            }
                        }label: {
                            Image(systemName: "document.on.clipboard.fill")
                                .foregroundStyle(.white)
                        }
                    }
                }
                if level4Data.solved {
                    AnimatedButtonMeshGradient(text: "Copy Password") {
                        UIPasteboard.general.string = password
                    }
                }
                hints()
                
                Color.clear.frame(height: 50)
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .padding(.top,20)
        }
        .audioPlayer2(audioName: "Think-Different", audioExtension: "mp3", trigger: $playSound)
        .particleEffect(systemImage: "star.fill", font: .largeTitle, status: level4Data.solved , activeTint: .yellow, inactiveTint: .secondary)
    }
   
    @ViewBuilder
   func hints() -> some View {
       Divider()
       hintView(index: 1, hint: "“This phrase was a rallying cry for Apple during its comeback era. It’s all about innovation and breaking the norm.”")
       hintView2(hint: "“This slogan appeared in one of Apple’s most iconic ad campaigns featuring thinkers like Einstein, Gandhi, and Picasso.”")
       hintView(index: 3, hint: "“Go back and check the Axicle terminal logs. There’s a clue hidden in its output.”")
       
       hintView(index: 4, hint: "“The key is: THINK DIFFERENT”")
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
    @ViewBuilder
    func hintView2(hint:String) -> some View {
        let index = 2
        
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
            if self.selectedHint    == index {
                playButton
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
    var playButton:some View {
        Button(action: {
            self.playSound.toggle()
        }) {
            HStack {
                Image(systemName: playSound ? "pause.fill" : "play.fill")
                    .font(.title)
                    .foregroundColor(.white)
                
                Text(playSound ? "Stop Ad" : "Play Ad")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.white)
            }
            .padding(10)
            .padding(.horizontal, 40)
            .background(
                    LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange, Color.yellow]), startPoint: .leading, endPoint: .trailing)
                )
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white, lineWidth: 2)
            )
            .scaleEffect(playSound ? 1.1 : 1.0)
            .animation(.spring(), value: playSound)
            .padding(.top, 20)
            .contentShape(Rectangle())
        }
       
       
    }
}

#Preview {
    let size = UIScreen.main.bounds.size
    Level4DecryptView(size:.init(width:size.width / 2,height: size.height / 1.3))
        .modifier(MacBackgroundStyle(size:.init(width:size.width / 2,height: size.height / 1.3),title: "Level 4"){
           
        })
}

