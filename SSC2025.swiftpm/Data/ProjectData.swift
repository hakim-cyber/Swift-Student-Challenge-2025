//
//  File.swift
//  SSC2025
//
//  Created by aplle on 1/11/25.
//

import SwiftUI



class ProjectData: ObservableObject {
    
    
    @Published  var userName: String = ""
    @Published var startSteps : StartSteps = .intro
    @Published var gameSteps : GameSteps = .openMessagesApp{
        didSet {
            handleStepsChange()
        }
    }
    @Published var selectedBackground:BackgroundImages = .proBlack
    @Published var stopDock = false
    
    @Published var notifications : [NotificationStruct] = []
    @Published var messages: [MessageViewStruct] = []
    
    
    @Published var openWindows: [WindowType] = []
    @Published var swipedwindows:[WindowType] = []
    
    @Published var showDock: Bool = true
    var dockWindows: [WindowType]{
        let alwaysOnDock = [WindowType.messages]
        let openedWindows = openWindows
        let swipedWindows = self.swipedwindows
        let combinedWindows = openedWindows + swipedWindows + alwaysOnDock
        
        return Array(Set(combinedWindows)).sorted(by: {$0.rawValue < $1.rawValue})
    }
    
    
    @Published var showedInfoAxicle = false
    @Published var showWWDCAnimation = false
    
    
    @Published var messageQueue: [MessageViewStruct] = []
    private var timer: Timer?
    @Published private var typingSpeed: TimeInterval = 0.01
   
    
  
    
    func bringToFront(_ window: WindowType) {
        if let index = openWindows.firstIndex(of: window) {
            openWindows.remove(at: index)
            openWindows.append(window)
        }
    }
    func swipeWindow(_ window: WindowType) {
        if !swipedwindows.contains(window) {
            swipedwindows.append(window)
            self.closeWindow(window)
        }
    }
    func removeFromSwipeList(_ window: WindowType) {
        if let index = swipedwindows.firstIndex(of: window) {
            swipedwindows.remove(at: index)
        }
    }
    func openWindow(_ window: WindowType) {
        if !openWindows.contains(window) {
            openWindows.append(window)
        }else{
            self.bringToFront(window)
        }
        removeFromSwipeList(window)
    }

    func closeWindow(_ window: WindowType) {
        if let index = openWindows.firstIndex(of: window) {
            openWindows.remove(at: index)
        }
    }
    func isWindowOpen(_ window: WindowType) -> Bool {
        return openWindows.contains(window)
    }
    
    func addMessagesToQueue(_ newMessages: [MessageViewStruct]) {
        messageQueue.append(contentsOf: newMessages)
        
        
        if timer == nil {
            processNextMessage()
        }
    }

    private func processNextMessage() {
        guard !messageQueue.isEmpty else {
           
            timer?.invalidate()
            timer = nil
            
            return
        }
      
       
        let nextMessage = messageQueue.removeFirst()
        messages.append(nextMessage)
        

        let delay = TimeInterval(nextMessage.text.count) * typingSpeed
        

        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
            self.processNextMessage()
        }
    }
    
    
    
    func handleStepsChange(){
        switch self.gameSteps {
        case .openMessagesApp:
           print("opened Messages")
        case .level1:
            let text1 = "Steve Jobs believed you could save us. Hackers locked the WWDC keynote, attendee list, and Axicle system. It's chaos!"
                let text2 = "Your mission: Solve their ciphers to recover the files. I’ll guide you along the way."
                let text3 = "Start with the keynote. Use the Caesar Cipher to decode the hacker’s message and uncover the password!"
          
            let message1 = MessageViewStruct(text:text1 , isIncoming: true)
            let message2 = MessageViewStruct(text:text2 , isIncoming: true)
            let message3 = MessageViewStruct(text:text3 , isIncoming: true)
            let message4 = MessageViewStruct(text: "Tip: Find the Keynote icon on your desktop and click to open it. It’s the blue app with a presentation stand!", isIncoming: true,messageStyle: .tip)
            self.addMessagesToQueue([message1,message2,message3,message4])
        case .level2:
            let text1 = "Here’s the unlocked keynote. What’s next?"
            let message1 = MessageViewStruct(text: text1, isIncoming: false)
            let message2 = MessageViewStruct(text: "Keynote", isIncoming: false,messageStyle:.file(Image("keynote"),"Keynote Document - 219 KB"),onTap: {
               
                self.openWindow(.mockKeynote)
             })
           
            let message3 = MessageViewStruct(text: "Great job! Now, we need the attendee list.", isIncoming: true)
            let message4 = MessageViewStruct(text: "The hacker hid it using Morse Code. Decode this to locate it", isIncoming: true)
            
            let morseCodeText = """
Encrypted Morse Code: "..- | ... | . | .-. | ... | ..-. | --- | .-.. | -.. | . | .-. "
"""
             let message5 = MessageViewStruct(text: morseCodeText, isIncoming: true)
             let message6 = MessageViewStruct(text: "Tip: Use the Morse Code tool on your desktop. ", isIncoming: true,messageStyle: .tip)
            let message7 = MessageViewStruct(text: "Morse Code Tool", isIncoming: true,messageStyle:.link(Image(.morseTool),"MorseCode.tool"),onTap: {
                  if self.gameSteps == .level2{
                      self.openWindow(.level2)
                  }
              })
            
             
                    
            self.addMessagesToQueue([message1,message2,message3,message4,message5,message6,message7])
                   
                       
                 
            
        case .usersFolder:
            let text1 = """
Navigate to the Users folder on the desktop and open the attendee file. Use the password you decoded in Level 1: 5FC@WWDC.
"""
            self.messages.append(MessageViewStruct(text: text1, isIncoming: true,messageStyle: .tip))
            
        case .level3:
          let message1 = MessageViewStruct(text: "Attendee Database", isIncoming: false,messageStyle:.file(Image(systemName: "text.document.fill"),"Attendee Database.txt - 100 KB"),onTap: {
             
              self.openWindow(.mockAttendeeDatabase)
          })
            
          
               
            let text2 = "You’ve saved the doors from chaos! But Axicle is still at risk."
            let message3 = MessageViewStruct(text: text2, isIncoming: true)
            let message4 = MessageViewStruct(text: "The Axicle backup key is corrupted. Decode the Atbash Cipher to restore it.", isIncoming: true)
            let message5 = MessageViewStruct(text: "Find the Axicle Terminal on your desktop and open it to start.", isIncoming: true, messageStyle: .tip)
                   
            self.addMessagesToQueue([message1, message3, message4, message5])
        case .level4:
            let message1 = MessageViewStruct(text: "Axicle is fully restored! 🎉", isIncoming: true, messageStyle: .congratulations)
                let message2 = MessageViewStruct(text: "You’ve saved WWDC. We’ve sent you a link to watch the live stream.", isIncoming: true, messageStyle: .congratulations)
                   let message3 = MessageViewStruct(
                       text: "WWDC Live Stream",
                       isIncoming: true,
                       messageStyle: .link(Image(systemName: "safari.fill"), "https://developer.apple.com/wwdc/2025"),
                       onTap: { if self.gameSteps == .level4 { self.openWindow(.level4Browser) } }
                   )
                   self.addMessagesToQueue([message1, message2, message3])
        case .noWifi:
           
            let text7 = "After decrypting the password, click the Wi-Fi icon in the toolbar to connect to the network."
            let message1 = MessageViewStruct(text: "The stream won’t load—no internet connection!", isIncoming: false)
                   let message2 = MessageViewStruct(
                       text: "Hackers encrypted the Wi-Fi password. Use the ‘Level 4 Decoder’ on your desktop to decrypt it.",
                       isIncoming: true
                   )
                   let message3 = MessageViewStruct(
                       text: "The decoder has four clues to help you find the key. Use them wisely.",
                       isIncoming: true,
                       messageStyle: .tip
                   )
            let message4 = MessageViewStruct(text: text7, isIncoming: true,messageStyle: .tip)
            self.addMessagesToQueue([message1, message2, message3,message4])
        case .connectedToWifi:
            let message1 = MessageViewStruct(text: "You’re connected to Wi-Fi!", isIncoming: true,messageStyle: .congratulations)
            let message2 = MessageViewStruct(text: "Now, try opening the WWDC live stream link again. It’s time to witness what you’ve worked so hard to save!", isIncoming: true)
            let message3 = MessageViewStruct(text: "WWDC Live Stream", isIncoming: true,messageStyle:.link(Image(systemName: "safari.fill"),"https://developer.apple.com/wwdc/2025"),onTap: {
                
               
                    self.showWWDCAnimation = true
               
                
            })
            self.addMessagesToQueue([message1, message2, message3])
        case .watchedAnimation:
           
            let message1 = MessageViewStruct(text: "Amazing job, Cipher Master! You’ve saved WWDC! 🎉", isIncoming: true, messageStyle: .congratulations)
                   let message2 = MessageViewStruct(
                       text: "Head to the Prizes folder on your desktop for your rewards.",
                       isIncoming: true,
                       messageStyle: .tip
                   )
                   self.addMessagesToQueue([message1, message2])
           
        default:
            print("new")
        }
    }
     func finishGameStep() {
        
         self.typingSpeed = 0.01
            guard let lastStep = GameSteps.allCases.last else { return }
            if gameSteps.rawValue < lastStep.rawValue {
                DispatchQueue.main.async {
                    self.gameSteps = GameSteps(rawValue: self.gameSteps.rawValue + 1) ?? self.gameSteps
                    self.finishGameStep() 
                }
            }
        }
}


enum StartSteps:String{
    case intro,helloView,nameView,desktopView
}

enum GameSteps:Int,CaseIterable{
    case openMessagesApp,level1,level2,usersFolder,level3,level4,noWifi,connectedToWifi,watchedAnimation
}

enum WindowType: Int, Equatable ,CaseIterable{
    case messages
    case level1
    case level2
    case usersFolder
    case level3
    case level4Browser
    case level4Wifi
    case level4Decoder
    case aboutMac
    case mockKeynote
    case mockAttendeeDatabase
    case prizeFolder
    case certificates
    case trophy
    case backgroundSelect
}
