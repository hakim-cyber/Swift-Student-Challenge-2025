//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/14/25.
//

import SwiftUI

struct WWDCEvent {
    let year: String
    let event: String
}
let steveWords:[String] = [
    "Cipher Master… you did it.",
    """
When hackers tried to derail WWDC 2025, you rose to the challenge.
You cracked their ciphers, restored the Axicle, and saved the keynote.
You didn’t just solve puzzles—you saved a global event.
""",
    "In the words of my younger self: ‘The people who are crazy enough to think they can change the world are the ones who do.’ Today, that’s you.",
    "Oh, and one more thing… your prize awaits in the Prize Folder on your desktop. You’ve earned it."
]

let wwdcTimeline: [WWDCEvent] = [
    WWDCEvent(year: "1983", event: "First WWDC. Apple introduces new programming tools for the Apple IIe."),
    WWDCEvent(year: "1984", event: "Macintosh System Software announced."),
    WWDCEvent(year: "1987", event: "Macintosh System Software 7 announced."),
    WWDCEvent(year: "1991", event: "Power Macintosh announced."),
    WWDCEvent(year: "1992", event: "QuickTime for Windows introduced."),
    WWDCEvent(year: "1997", event: "Steve Jobs returns to Apple."),
    WWDCEvent(year: "2000", event: "Mac OS X introduced."),
    WWDCEvent(year: "2001", event: "First iPod released."),
    WWDCEvent(year: "2002", event: "iTunes Store launched."),
    WWDCEvent(year: "2003", event: "Safari browser announced."),
    WWDCEvent(year: "2004", event: "The original iMac G5 introduced."),
    WWDCEvent(year: "2005", event: "Apple switches to Intel processors for Macs."),
    WWDCEvent(year: "2006", event: "MacBook Pro introduced."),
    WWDCEvent(year: "2007", event: "iPhone announced."),
    WWDCEvent(year: "2008", event: "App Store launched."),
    WWDCEvent(year: "2009", event: "iPhone OS 3.0 with MMS support."),
    WWDCEvent(year: "2010", event: "iOS 4 introduced, featuring multitasking."),
    WWDCEvent(year: "2011", event: "iCloud launched."),
    WWDCEvent(year: "2012", event: "Retina Display announced for MacBook Pro."),
    WWDCEvent(year: "2013", event: "OS X Mavericks and iOS 7 announced."),
    WWDCEvent(year: "2014", event: "Swift programming language introduced."),
    WWDCEvent(year: "2015", event: "Apple Watch announced."),
    WWDCEvent(year: "2016", event: "ARKit and SiriKit introduced."),
    WWDCEvent(year: "2017", event: "iMac Pro and iOS 11 introduced."),
    WWDCEvent(year: "2018", event: "iOS 12 introduced with Dark Mode."),
    WWDCEvent(year: "2019", event: "iPadOS and macOS Catalina introduced."),
    WWDCEvent(year: "2020", event: "Apple Silicon announced."),
    WWDCEvent(year: "2021", event: "iOS 15 and macOS Monterey introduced."),
    WWDCEvent(year: "2022", event: "M2 Chip and iOS 16 introduced."),
    WWDCEvent(year: "2023", event: "Vision Pro and spatial computing introduced."),
    WWDCEvent(year: "2024", event: "iOS 17, macOS 14 announced."),
    WWDCEvent(year: "2025", event: "")
]
struct WWDCAnimationView: View {
    @State private var sizeOfScreen = UIScreen.main.bounds.size
    @State private var scrollOffset: CGFloat = 0
    @State private var finalMessage = false

    @State private var step:WWDCTimelineStep = .none
    
    @State private var steveSpeech = 0
   
    var close:()->Void
    var body: some View {
        ZStack {
            
            Color.black.ignoresSafeArea()
            switch step {
            case .start:
                Text("Apple’s WWDC – A Journey of Innovation")
                                    .font(.title)
                                    .bold()
                                    .background(Color.black.opacity(0.7))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding(20)
                                    .transition(.opacity)
                                   
                                    .fixedSize()
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                            withAnimation(.easeInOut(duration: 2)){
                                                self.step = .timeline
                                            }
                                        }
                                    }
                                   
            case .timeline:
               
                HStack {
                  
                    
                    ForEach(wwdcTimeline, id: \.year) { event in
                        VStack {
                            Text("\(event.year)")
                                .font(.system(size: 100))
                                .foregroundColor(.white)
                                .fontWeight(.black)
                            Text(event.event)
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                        }
                        .padding(30)
                        .frame(width: self.sizeOfScreen.width,alignment: .center)
                    }
                    
                }
                .offset(x: scrollOffset)
                .onAppear {
                   
                    scrollOffset = CGFloat(wwdcTimeline.count / 2 ) *  self.sizeOfScreen.width - self.sizeOfScreen.width / 2.5
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                        withAnimation(Animation.timingCurve(0.9,0.6, 0.4, 0.2, duration: 8)) {
                            
                            scrollOffset = CGFloat(-wwdcTimeline.count / 2) *  sizeOfScreen.width + sizeOfScreen.width / 2.5
                            
                        }
                    }
                   
                }
                .transition(.asymmetric(insertion: .opacity, removal: .identity))
             
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 11) {
                        withAnimation(.easeInOut(duration: 2)){
                            self.step = .final
                        }
                    }
                }
               
            case .final:
                Text("Coming Soon! Stay Tuned")
                                       .font(.system(size: 60))
                                       .foregroundColor(.white)
                                       .fontWeight(.black)
                                       .transition(.opacity)
                                       .onAppear {
                                           DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                               withAnimation(.easeInOut(duration: 2)){
                                                   self.step = .save
                                               }
                                           }
                                       }
            case .save:
             
                    wwdc2025
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                            withAnimation(.easeInOut(duration: 2)){
                                self.step = .thanks1
                            }
                        }
                    }
                    
                
            case .none:
                Color.black
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeInOut(duration: 2)){
                                self.step = .start
                            }
                        }
                    }
            case .thanks1:
               
                
                ZStack{
                 
                   
                    VStack{
                        Spacer()
                        wwdc2025
                        Spacer()
                        Spacer()
                    }
                     
                    
                   
                   
                    ZStack{
                       
                       
                        VStack(spacing:0){
                            HStack{
                                Spacer()
                                Image(.steve)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height:300)
                                   
                            }
                            ZStack{
                                Rectangle()
                                    .fill(.regularMaterial)
                                
                                    .ignoresSafeArea()
                                VStack(alignment: .leading,spacing:20){
                                    Text("Steve Jobs:")
                                        .font(.system(size: 25, weight: .black, design: .monospaced))
                                        .foregroundStyle(Color.white)
                                    Text(steveWords[self.steveSpeech])
                                        .multilineTextAlignment(.leading)
                                        .font(.system(size: 25, weight: .black, design: .monospaced))
                                        .foregroundStyle(Color.white)
                                    
                                }
                                
                                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
                                .padding(30)
                                .overlay(alignment: .bottom) {
                                    HStack{
                                        Spacer()
                                        Button("Next"){
                                            if steveSpeech < steveWords.count - 1{
                                                steveSpeech += 1
                                            }else{
                                                withAnimation(.easeInOut(duration: 2)){
                                                    self.step = .thanks2
                                                }
                                            }
                                        }
                                        .font(.system(size: 35, weight: .black, design: .monospaced))
                                        .foregroundStyle(Color.orange)
                                    }
                                    .padding()
                                    .padding(.horizontal)
                                }
                            }
                            
                            .frame(height: self.sizeOfScreen.height / 4)
                            
                           
                        }
                        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottom)
                        
                        
                    }
                    
                }
                
                
            case .thanks2:
                ZStack{
                 
                   
                    VStack{
                        Spacer()
                        wwdc2025
                        Spacer()
                        Spacer()
                    }
                     
                    
                   
                    
                    ZStack{
                       
                       
                 
                            ZStack{
                                Rectangle()
                                    .fill(.regularMaterial)
                                
                                    .ignoresSafeArea()
                                VStack(alignment: .leading,spacing:20){
                                    Text("Head to your desktop to claim your prize from the Prize Folder.")
                                        .font(.system(size: 25, weight: .black, design: .monospaced))
                                        .foregroundStyle(Color.white)
                                }
                                
                                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
                                .padding(30)
                                .overlay(alignment: .bottom) {
                                    HStack{
                                       
                                        Button("Desktop"){
                                            close()
                                        }
                                        .font(.system(size: 35, weight: .black, design: .monospaced))
                                        .foregroundStyle(Color.orange)
                                    }
                                    .padding()
                                    .padding(.horizontal)
                                }
                            }
                            
                            .frame(height: self.sizeOfScreen.height / 5)
                        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottom)
                        
                        
                    }
                    
                }
                
            }
           
        }
        .animation(.easeInOut, value: step)
        .audioPlayer2(audioName: "cinematic2", audioExtension: "mp3", trigger: .constant(self.step != .none))
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                       
                  
                   Task { @MainActor in
                       try await Task.sleep(for: .seconds(0.001))
                       withAnimation{
                           self.sizeOfScreen = UIScreen.main.bounds.size
                       }
                   }
               }
       
    }
    var wwdc2025:some View{
        VStack(spacing:25){
            HStack{
                Image(systemName: "apple.logo")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .fontWeight(.black)
                    .transition(.opacity)
                Text("WWDC25")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .fontWeight(.black)
                    .transition(.opacity)
            }
            Text("Dream Big. Code Bigger.")
                .font(.system(size: 50))
                .foregroundStyle(
                                LinearGradient(gradient: Gradient(colors: [Color.orange, Color.pink]), startPoint: .top, endPoint: .bottom)
                            )
                .fontWeight(.black)
                .transition(.opacity)
            VStack{
                Text("Apple Worldwide Developers Conferene")
                Text("Arriving Spring 2025")
              
            }
            .font(.system(size: 23))
        }
    }
}

struct WWDCAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        WWDCAnimationView{
            
        }
    }
}

enum WWDCTimelineStep{
    case none,start,timeline,final,save,thanks1,thanks2
}
