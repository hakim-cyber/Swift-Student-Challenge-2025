//
//  File.swift
//  SSC2025
//
//  Created by aplle on 1/11/25.
//

import SwiftUI



class ProjectData: ObservableObject {
    
    
    @Published  var userName: String = ""
    @Published var startSteps : StartSteps = .helloView
    @Published var gameSteps : GameSteps = .openMessagesApp{
        didSet {
            handleStepsChange()
        }
    }
    
    
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
    private var typingSpeed: TimeInterval = 0.025
   
    
    // Time per character
    
    func bringToFront(_ window: WindowType) {
        if let index = openWindows.firstIndex(of: window) {
            openWindows.remove(at: index)
            openWindows.append(window) // Move the window to the end
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
        
        // Start the timer if it's not already running
        if timer == nil {
            processNextMessage()
        }
    }

    private func processNextMessage() {
        guard !messageQueue.isEmpty else {
            // Stop the timer when all messages are sent
            timer?.invalidate()
            timer = nil
            
            return
        }
      
        // Get the next message from the queue
        let nextMessage = messageQueue.removeFirst()
        messages.append(nextMessage)
        
        // Calculate the delay based on the length of the message text
        let delay = TimeInterval(nextMessage.text.count) * typingSpeed
        
        // Schedule the next message after the delay
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
            self.processNextMessage()
        }
    }
    
    
    
    func handleStepsChange(){
        switch self.gameSteps {
        case .openMessagesApp:
           print("opened Messages")
        case .level1:
            let text1 = """
Hey there! Steve Jobs had a feeling you’d be the one to save us.

Hackers have locked the WWDC keynote, the attendee list, and even Apple’s Axicle system.

It’s total chaos here. But there’s hope—you.”
"""
            let text2 = """
“Your mission: recover critical information by solving the hackers’ ciphers.

Each file you decrypt unlocks the next step in the rescue. Don’t worry—I’ll guide you.”
"""
            let text3 = "“Start with the Keynote. The hacker left an encrypted message. Decode it to get the password!”"
            let message1 = MessageViewStruct(text:text1 , isIncoming: true)
            let message2 = MessageViewStruct(text:text2 , isIncoming: true)
            let message3 = MessageViewStruct(text:text3 , isIncoming: true)
            let message4 = MessageViewStruct(text: "Tip: Find the Keynote icon on your desktop and click to open it. It’s the blue app with a presentation stand!", isIncoming: true,messageStyle: .tip)
            self.addMessagesToQueue([message1,message2,message3,message4])
        case .level2:
            let text1 = "Here’s the unlocked keynote. What’s next?"
            let message1 = MessageViewStruct(text: text1, isIncoming: false)
            let message2 = MessageViewStruct(text: "Keynote", isIncoming: false,messageStyle:.file(Image("keynote"),"Keynote Document - 219 KB"),onTap: {
                // open keynote showing file
             })
           
            let message3 = MessageViewStruct(text: "Great job unlocking the keynote! We’re one step closer to saving WWDC.", isIncoming: true)
            let message4 = MessageViewStruct(text: "Next, we need to recover the attendee list. The hacker hid the list in the system, and the location is encrypted in Morse Code.", isIncoming: true)
            
            let morseCodeText = """
Encrypted Morse Code: "..- | ... | . | .-. | ... | ..-. | --- | .-.. | -.. | . | .-. "
"""
             let message5 = MessageViewStruct(text: morseCodeText, isIncoming: true)
             let message6 = MessageViewStruct(text: "Use the Morse Code tool in the system to decode it ", isIncoming: true,messageStyle: .tip)
            let message7 = MessageViewStruct(text: "Morse Code Tool", isIncoming: true,messageStyle:.link(Image(.morseTool),"MorseCode.tool"),onTap: {
                  if self.gameSteps == .level2{
                      self.openWindow(.level2)
                  }
              })
            
              let message8 = MessageViewStruct(text: "Once decoded, head to the correct location to find the attendee list file and use the password from Level 1", isIncoming: true,messageStyle: .tip)
                    
            self.addMessagesToQueue([message1,message2,message3,message4,message5,message6,message7,message8])
                   
                       
                 
            
        case .usersFolder:
            let text1 = """
Navigate to the Users Folder on the desktop. Once there, open the attendee file. You’ll need the password you just decoded in Level 1 (5FC@WWDC) to unlock it.
"""
            self.messages.append(MessageViewStruct(text: text1, isIncoming: true,messageStyle: .tip))
            
        case .level3:
          let message1 = MessageViewStruct(text: "Attendee Database", isIncoming: false,messageStyle:.file(Image(systemName: "text.document.fill"),"Attendee Database.txt - 100 KB"),onTap: {
              // open attendee database showing file
          })
            let text1 = "I’ve sent the attendee list. Are we good to go?"
          let message2 = MessageViewStruct(text: text1, isIncoming: false)
               
            let text2 = "You’ve saved the doors from chaos! But the Axicle system is still at risk. Let’s secure it."
            let message3 = MessageViewStruct(text: text2, isIncoming: true)
            let message4 = MessageViewStruct(text: "The Axicle system’s backup key is corrupted. Decode the Atbash Cipher to restore it.", isIncoming: true)
            let message5 = MessageViewStruct(text: "The key is stored in the Axicle Terminal on your desktop. Open it to get started.", isIncoming: true, messageStyle: .tip)
                   
            self.addMessagesToQueue([message1, message2, message3, message4, message5])
        case .level4:
            let text1 = "Congratulations! Thanks to you, the Axicle system is now fully restored, and WWDC is back on track."
            let text2 = "You’ve truly saved the day! 🎉"
            let text3 = "We’ve sent you an exclusive link to watch the WWDC live stream."
            let text4 = "There’s something very special waiting for you—don’t miss it!"
            
            let message1 = MessageViewStruct(text: "Axicle is now fully restored!", isIncoming: false)
            let message2 = MessageViewStruct(text: text1, isIncoming: true)
           
            let message3 = MessageViewStruct(text: text2, isIncoming: true,messageStyle: .congratulations)
            let message4 = MessageViewStruct(text: text3, isIncoming: true)
         let message5 = MessageViewStruct(text: text4, isIncoming: true,messageStyle: .tip)
            let message6 = MessageViewStruct(text: "WWDC Live Stream", isIncoming: true,messageStyle:.link(Image(systemName: "safari.fill"),"https://developer.apple.com/wwdc/2025"),onTap: {
                if self.gameSteps == .level4 {
                    self.openWindow(.level4Browser)
                }
               
            })
                    
            self.addMessagesToQueue([message1, message2, message3, message4, message5, message6])
        case .noWifi:
            let text1 = "Uh… there’s a problem. The stream won’t load—it says there’s no internet connection."
            let text2 = "Oh no! It seems the hackers encrypted the Wi-Fi password, cutting us off from the network."
            let text3 = "Figures. What’s the plan now?"
            let text4 = "To get back online, you need to decrypt the Wi-Fi password. The tool for this is on your desktop—it’s called the ‘Level 4 Decoder.’ Open it and enter the key to decode"
            
            let text5 = "What about the key?"
            let text6 = "The key is hidden. There are hints in the ‘Level 4 Decoder’ itself. It will give you four clues to guide you. Keep an eye out for them, they’ll help you find the key!"
            let text7 = "Once you’ve decrypted the password, go to the toolbar and tap on the Wi-Fi icon to connect"
            let message1 = MessageViewStruct(text: text1, isIncoming: false)
            let message2 = MessageViewStruct(text: text2, isIncoming: true)
            let message3 = MessageViewStruct(text: text3, isIncoming: false)
            let message4 = MessageViewStruct(text: text4, isIncoming: true)
            let message5 = MessageViewStruct(text: text5, isIncoming: false)
            let message6 = MessageViewStruct(text: text6, isIncoming: true)
            let message7 = MessageViewStruct(text: text7, isIncoming: true,messageStyle: .tip)
            
            self.addMessagesToQueue([message1, message2, message3, message4, message5, message6, message7])
        case .connectedToWifi:
            let message1 = MessageViewStruct(text: "You’re connected to Wi-Fi!", isIncoming: true,messageStyle: .congratulations)
            let message2 = MessageViewStruct(text: "Now, try opening the WWDC live stream link again. It’s time to witness what you’ve worked so hard to save!", isIncoming: true)
            let message3 = MessageViewStruct(text: "WWDC Live Stream", isIncoming: true,messageStyle:.link(Image(systemName: "safari.fill"),"https://developer.apple.com/wwdc/2025"),onTap: {
                // open wwdc animation and final
               
                    self.showWWDCAnimation = true
               
                
            })
            self.addMessagesToQueue([message1, message2, message3])
        case .watchedAnimation:
            // congratulate , say him to get hiz prizes and say your mission finished
            let message1 = MessageViewStruct(text: "What a journey, Cipher Master! Steve was truly impressed with your brilliance, and so are we.", isIncoming: true)
            let message2 = MessageViewStruct(text: "Your mission is now complete, and you’ve saved WWDC 🎉", isIncoming: true,messageStyle: .congratulations)
            let message3 = MessageViewStruct(text: "Head over to the Prizes folder on your desktop and check out what’s waiting for you!", isIncoming: true,messageStyle: .tip)
            let message4 = MessageViewStruct(text: "Once again, congratulations on a job well done. You’re officially a legend!", isIncoming: true,messageStyle: .congratulations)
            self.addMessagesToQueue([message1, message2, message3, message4])
           
        default:
            print("new")
        }
    }
}


enum StartSteps:String{
    case helloView,nameView,desktopView
}

enum GameSteps:Int{
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
}
