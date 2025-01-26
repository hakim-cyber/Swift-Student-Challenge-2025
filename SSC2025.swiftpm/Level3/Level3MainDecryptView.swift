//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/8/25.
//

import SwiftUI

struct Level3MainDecryptView: View {
    @EnvironmentObject var data: ProjectData
    @EnvironmentObject var level3Data: Level3Data
    @State private var newText: String = ""
    @FocusState private var focusedField: Bool
    
  
    
    let size:CGSize
    @State private var showTextField: Bool = true
    
    let encryptedMessage = "LMV NLIV GSRMT"
    let correctEncryptedMessage = String("One more thing").trimAllSpace().lowercased()
    
  
    var close:()->Void
    var body: some View {
        ZStack{
           if self.data.gameSteps == .level3{
               data.selectedBackground.image
                    .resizable()
                    .ignoresSafeArea()
            }
            GeometryReader{geo in
                ScrollViewReader{scroll in
                    ScrollView{
                        VStack(alignment: .leading,spacing: 10){
                            
                            startLoginmessage
                            
                            
                            ForEach(self.level3Data.messages) { message in
                                let isLevel4 = data.gameSteps == .noWifi
                                if !isLevel4{
                                    Text(message.message)
                                        .foregroundStyle(message.color)
                                }else{
                                    if message.isLevel4Key{
                                        ShiningText(text:message.message)
                                    }else{
                                        Text(message.message)
                                       
                                    }
                                }
                                
                            }
                            if showTextField{
                                textView
                                    .id("TextView")
                            }
                            Color.clear.frame(height:50)
                                .id("space")
                        }

                        .multilineTextAlignment(.leading)
                        .fontWeight(.bold)
                        .padding()
                    }
                    .onChange(of: self.level3Data.messages) { oldValue, newValue in
                        
                            scroll.scrollTo("space")
                        
                    }
                    .onAppear{
                        scroll.scrollTo("space")
                    }
                }
                
            }
            .modifier(MacBackgroundStyle(size:.init(width:size.width / 1.5,height: size.height / 1.5),title:"Level 3: Terminal"){
               
                    self.data.closeWindow(.level3)
                self.data.showDock = true
                
                })
            .particleEffect(systemImage: "star.fill", font: .largeTitle, status: self.level3Data.celebrate && self.data.gameSteps != .noWifi, activeTint: .yellow, inactiveTint: .secondary)
           
            
        }
        
        .onAppear{
            if self.data.gameSteps == .level3{
                self.data.showDock = false
            }
            if self.level3Data.messages.isEmpty{
                self.level3Data.tips.removeAll()
                self.level3Data.tips.append(Tip(message: "Type  start",copy: "start"))
                self.focusedField = true
            }
           
        }
        .overlay(alignment:.topTrailing){
            tipsView
        }
    }
    var startLoginmessage: some View {
        Text("Last login: ") + Text((Date.now - 300).formatted(date: .long, time: .shortened))
    }
    @ViewBuilder
    var textView: some View {
        let name =  (self.data.userName == "" ? "Master" : self.data.userName).lowercased()
        HStack{
            Text("\(name)@\(name)'s Mac ~ %")
            TextField("", text: $newText)
                .accentColor(.cyan)
                .foregroundStyle(.white)
                .focused($focusedField)
                .onSubmit {
                    self.level3Data.messages.append(Message(message: "\(name)@\(name)'s Mac ~ %  \(newText)"))
                    
                    self.responceToMessage(message: newText)
                    self.newText = ""
                    self.focusedField = true
                }
                
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                
        }
        .padding(.bottom)
      
    }
   
    var tipsView: some View {
        VStack(alignment: .trailing){
            ForEach(self.level3Data.tips){tip in
                Button{
                    if tip.copy != ""{
                        UIPasteboard.general.string = tip.copy
                        self.focusedField = true
                    }
                }label: {
                    HStack{
                        Text(tip.message)
                           
                            .bold()
                        
                        if tip.copy != ""{
                            Image(systemName: "document.on.document.fill")
                              
                        }
                        
                    }
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .multilineTextAlignment(.leading)
                    
                }
                .foregroundStyle(.white)
                   
                
            }
        }
        .animation(.easeInOut(duration: 0.2), value: self.level3Data.tips.count)
        .padding(30)
        .frame(maxWidth:.infinity,maxHeight: .infinity, alignment: .topTrailing)
       
       
        
    }
    
    func responceToMessage(message:String){
        let messageTrimmed = message.trimAllSpace().lowercased()
        switch self.level3Data.step {
        case .start:
            
            if messageTrimmed == "start"{
                self.showTextField = false
                self.level3Data.messages.append(Message(message: "[INITIALIZING...]" ))
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                    let newMessage1 = """

[WELCOME TO MISSION 3: RECOVERING THE BACKUP KEY]  

[INFO] Axicle’s backup key has been encrypted by hackers using the Atbash cipher.  

[INFO] Your mission:  
  1. Decode the encrypted key using the Atbash cipher.  
  2. Use the key to secure Axicle and restore the WWDC systems.  

[INFO] Reminder: Atbash reverses the alphabet.  
Example: A ↔ Z, B ↔ Y, C ↔ X...  
"""
                    self.level3Data.messages.append(Message(message: newMessage1 ))
                    
                    
                    
                    self.level3Data.tips.removeAll()
                    self.level3Data.step = .proceed
                    self.level3Data.tips.append(Tip(message: "Type `proceed` when you're ready to move forward.",copy: "proceed"))
                    self.showTextField = true
                }
            }else{
                
                incorrectCommand(message: message)
            }
            
        case .proceed:
            
            if messageTrimmed == "proceed"{
                self.showTextField = false
                self.level3Data.tips.removeAll()
                
                self.level3Data.messages.append(Message(message: "[PROCESSING...]" ))
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                    let newMessage1 = """
[READY] Decrypt the message below to recover the backup key.

[ENCRYPTED MESSAGE]  
"""
                    self.level3Data.messages.append(Message(message: newMessage1))
                    let newMessage2 = self.encryptedMessage
                    
                    self.level3Data.messages.append(Message(message: newMessage2,color: .green))
                    
                    self.level3Data.tips.append(Tip(message: "The Atbash cipher reverses the alphabet"))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        self.level3Data.tips.append(Tip(message:"Need help decoding? Type `alphabet` to see the Atbash cipher mapping.",copy: "alphabet"))
                    }
                    self.showTextField = true
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                        if self.level3Data.step == .proceed{
                            let additionalTip = """
                                [HINT] Struggling to decode the backup key?  
                                Type `key` to get help with finding the decrypted letters!  
                                """
                            self.level3Data.tips.append(Tip(message: additionalTip,copy: "key"))
                        }
                    }
                }
            }else if messageTrimmed == "alphabet"{
                let newMessage1 = """
[ALPHABET KEY]  
A ↔ Z | B ↔ Y | C ↔ X | D ↔ W | E ↔ V | F ↔ U | G ↔ T  

H ↔ S | I ↔ R | J ↔ Q | K ↔ P | L ↔ O | M ↔ N  

N ↔ M | O ↔ L | P ↔ K | Q ↔ J | R ↔ I | S ↔ H  

T ↔ G | U ↔ F | V ↔ E | W ↔ D | X ↔ C | Y ↔ B | Z ↔ A  

[HINT] Notice how the alphabet mirrors itself? Use this to decrypt! 

[ENCRYPTED MESSAGE] 
"""
                self.level3Data.messages.append(Message(message: newMessage1))
                let newMessage2 = self.encryptedMessage
                
                self.level3Data.messages.append(Message(message: newMessage2,color: .green))
                
                
               
            }else if messageTrimmed == "key"{
               
                let messageHelp = """
                            [HELP: DECODING THE ENCRYPTED MESSAGE]  

                            Here’s how the Atbash cipher works:  
                            - The alphabet is reversed: A ↔ Z, B ↔ Y, C ↔ X...  

                            Let’s break it down step by step:  
                            1. Take the first encrypted word: **LMV**  
                               - L ↔ O  
                               - M ↔ N  
                               - V ↔ E  
                               → Decoded: **ONE**  

                            2. Next encrypted word: **NLIV**  
                               - N ↔ M  
                               - L ↔ O  
                               - I ↔ R  
                               - V ↔ E  
                               → Decoded: **MORE**  

                            3. Final encrypted word: **GSRMT**  
                               - G ↔ T  
                               - S ↔ H  
                               - R ↔ I  
                               - M ↔ N  
                               - T ↔ G  
                               → Decoded: **THING**  
                            
                            Now Combine them and type to complete key recovery
                            """
                self.level3Data.messages.append(Message(message: messageHelp))
                
            }
            else if messageTrimmed == self.correctEncryptedMessage{
                self.showTextField = false
                self.level3Data.tips.removeAll()
               
                let message1 = Message(message: "[VALID] LMV → ONE")
                let message2 = Message(message: "[VALID] NLIV → MORE ")
                let message2_1 = Message(message: "[VALID] GSRMT → THING ")
                
                self.level3Data.messages.append(message1)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    self.level3Data.messages.append(message2)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        self.level3Data.messages.append(message2_1)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            let message3 = Message(message: """
[DECRYPTION SUCCESSFUL]  
[KEY RECOVERED] ONE MORE THING  
""",color:.green)
                            self.level3Data.messages.append(message3)
                            self.level3Data.tips.append(Tip(message: "Type `use key` to apply the decoded backup key and proceed to secure Axicle.",copy: "use key"))
                            self.level3Data.step = .usingKey
                            self.showTextField = true
                            
                        }
                    }
                }
                
            }else{
                incorrectCommand(message: message)
                
            }
            
            
        case .usingKey:
            if messageTrimmed == "usekey"{
                self.showTextField = false
                self.level3Data.tips.removeAll()
                
                let message1 = Message(message: "[PROCESSING...]")
                let message2 = Message(message: "The Key is ready to be used.")
                
                self.level3Data.messages.append(message1)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    self.level3Data.messages.append(message2)
                    self.level3Data.step = .secureAxicle
                    self.level3Data.tips.append(Tip(message: "Type `secure axicle` to finalize the mission.",copy: "secure axicle"))
                    self.showTextField = true
                }
            }else{
                incorrectCommand(message: message)
            }
        case .secureAxicle:
            if messageTrimmed == "secureaxicle"{
                self.level3Data.tips.removeAll()
                self.showTextField = false
                let message1 = Message(message: "[VERIFYING KEY...]")
                let message2 = Message(message: "[VALIDATING...]")
                let message3 = Message(message: "Backup Key Verified: ONE MORE THING")
                let message4 = Message(message: "Axicle system restored and secured!")
                
                let celebratoryMessage = """
Axicle is now safe, and the WWDC systems are online. Great work, agent!

The hackers left a hidden message: "Enjoy WWDC, but this isn’t over!"
"""
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    self.level3Data.messages.append(message1)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        self.level3Data.messages.append(message2)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            self.level3Data.messages.append(message3)
                            self.level3Data.messages.append(message4)
                            
                            self.level3Data.celebrate = true
                            self.close()
                            
                            self.level3Data.messages.append(Message(message: celebratoryMessage,color:.green))
                            
                            let level4Key = "You’ve secured Axicle. But remember, sometimes to solve the hardest puzzles, you need to “Think Different“"
                            self.level3Data.messages.append(Message(message:level4Key,isLevel4Key: true))
                            
                            self.showTextField = true
                            
                            self.level3Data.step = .extraCheck
                            self.level3Data.tips.append(Tip(message: "Type `git status` for a fun check on the mission's progress.",copy: "git status"))
                            self.level3Data.tips.append(Tip(message: "This command simulates checking for uncommitted changes—like a true developer!"))
                        }
                    }
                }
               
            }else{
                incorrectCommand(message: message)
            }
        case .extraCheck:
            if messageTrimmed == "gitstatus"{
                self.level3Data.tips.removeAll()
                
                
                self.level3Data.messages.append(Message(message: "[INFO] All systems clean. No uncommitted changes."))
                
                self.level3Data.tips.append(Tip(message: "Type `git commit -m Mission` to celebrate your win with a developer's flair.",copy: "git commit -m Mission"))
                self.level3Data.tips.append(Tip(message: "Commit your success"))
                
            }else if messageTrimmed == "gitcommit-mmission"{
                
                self.level3Data.messages.append(Message(message: "[INFO] Changes committed to WWDC branch. Ready to deploy. 🎉 "))
                self.level3Data.tips.removeAll()
                
                
            }else{
                incorrectCommand(message: message)
            }
       
        }
    }
    func incorrectCommand(message:String){
        self.level3Data.messages.append(Message(message: "zsh: command not found: \(message)"))
        
    }
}

#Preview {
   
    Level3MainDecryptView(size: UIScreen.main.bounds.size){
        
    }
        .environmentObject(ProjectData())
        .environmentObject(Level3Data())
      
}
 

struct Message:Identifiable,Equatable{
    var id:UUID = UUID()
    var message:String
    var color:Color = .white
    var isLevel4Key:Bool = false
}
struct Tip:Identifiable,Equatable{
    var id:UUID = UUID()
    var message:String
    var copy:String = ""
}

enum Level3Steps:CaseIterable{
    case start,proceed,usingKey,secureAxicle,extraCheck
}

extension String{
    func trimAllSpace()->String{
        return self.replacingOccurrences(of: "\\s", with: "", options: .regularExpression)
    }
}
