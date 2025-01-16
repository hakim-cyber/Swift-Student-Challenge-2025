//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/17/25.
//

import SwiftUI
enum KeynoteSteps: Int, CaseIterable{
    case appleLogo
    case iphone
   
}

struct KeynoteView: View {
    let size:CGSize
    @State private var isRevealed = false
    @State private var selectedStep: Int = 0
    
    @State private var scale: CGFloat = 1
    @State private var lastScale: CGFloat = 1
    
    var swipe:(()->Void)?
    var close:(()->Void)?
    var body: some View {
        GeometryReader{ geo in
            let size = geo.size
            HStack(spacing: 0) {
                
                // Keynote Sidebar
                
                ScrollView(.vertical){
                    VStack(spacing:20){
                        
                            ForEach(keynoteSections.indices,id:\.self) { count in
                            
                            Button {
                                self.selectedStep = count
                            } label: {
                                VStack {
                                    
                                    keynoteSlide(index: count,width:  size.width * 0.15 - 35)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                        .padding(5)
                                       
                                        .background{
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(selectedStep == count ? Color.gray.opacity(0.2) :Color.clear)
                                        }
                                    Text("\(count + 1)")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .fixedSize()
                                        .bold()
                                        .padding(5)
                                        .background{
                                            RoundedRectangle(cornerRadius: 6)
                                                .fill(selectedStep == count ? Color.gray.opacity(0.2) :Color.clear)
                                        }
                                }
                            }
                          
                        }
                        Color.clear.frame(height: 100)
                    }
                    .padding(.top)
                   
                    
                }
               
                    .frame(width: size.width * 0.15)
                    .background(.thinMaterial)
                Spacer()
               
                    VStack(spacing: 0) {
                        
                        
                        keynoteSlide(index: selectedStep, width: geo.size.width * 0.7)
                            .scaleEffect(scale)
                         
                      
                        
                    }
                    .zIndex(-4)
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .gesture(MagnificationGesture()
                             
                        .onChanged { value in
                            
                                let scaleChange = value - 1
                            let newScale =  min(max(lastScale + scaleChange, 0.35), 1.5)
                                
                                
                                
                                self.scale = newScale
                            
                        }
                        
                        .onEnded({ value in
                            
                                
                            lastScale = scale
                               
                            
                        }))
                }
            
        }
        .modifier(MacBackgroundStyle(size:.init(width:size.width / 1.3,height: size.height / 1.5), title: "Keynote", movable: true,swipe: {
            swipe?()
        },close:{
            close?()
        }))
        
    }
        
    @ViewBuilder
    func keynoteSlide(index:Int,width:CGFloat) ->some View{
        let height = width * 9 / 16
        
            ZStack{
                let slideInfo = keynoteSections[index]
                slideInfo.gradient.ignoresSafeArea()
                VStack(spacing: 10) {
                    Image(systemName: slideInfo.systemImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width / 8)
                        .foregroundColor(.white)
                    
                    Text(slideInfo.title)
                        .font(.system(size: width / 20))
                        .fontWeight(.black)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    
                    Text(slideInfo.subtitle)
                        .font(.system(size: width / 35))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                }
               
                .padding(width / 15)
                
            }
             .frame(width: width,height: height)
    }

}

#Preview {
    let size = UIScreen.main.bounds.size
    KeynoteView(size: size)
       
        
}

let keynoteSections = [
    (
        title: "Welcome to WWDC 2025",
        subtitle: "The future of technology begins today. Let's dive in!",
        systemImage: "globe",
        gradient: LinearGradient(
            gradient: Gradient(colors: [Color.blue, Color.cyan]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    ),
    (
        title: "iOS 19: The Future is Now",
        subtitle: "AI, privacy, and performance at the heart of iOS 19.",
        systemImage: "iphone.homebutton",
        gradient: LinearGradient(
            gradient: Gradient(colors: [Color.blue, Color.purple]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    ),
    (
        title: "iPadOS 19: Power Meets Creativity",
        subtitle: "Multitasking and Apple Pencil enhancements bring iPad even closer to Mac.",
        systemImage: "ipad.landscape",
        gradient: LinearGradient(
            gradient: Gradient(colors: [Color.orange, Color.red]),
            startPoint: .top,
            endPoint: .bottom
        )
    ),
    (
        title: "macOS 14: The Ultimate Productivity Tool",
        subtitle: "Refinements and Apple Silicon optimizations for an even more powerful Mac experience.",
        systemImage: "macmini",
        gradient: LinearGradient(
            gradient: Gradient(colors: [Color.gray, Color.black]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    ),
    (
        title: "watchOS 12: Your Health, Your Priority",
        subtitle: "New workout types and advanced health sensors keep you fit and informed.",
        systemImage: "applewatch",
        gradient: LinearGradient(
            gradient: Gradient(colors: [Color.green, Color.blue]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    ),
    (
        title: "tvOS 17: Entertainment Reimagined",
        subtitle: "A new home screen and seamless gaming and streaming integration.",
        systemImage: "tv",
        gradient: LinearGradient(
            gradient: Gradient(colors: [Color.pink, Color.purple]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    ),
    (
        title: "AR/VR: A New Reality",
        subtitle: "The future of immersive technology is here with our AR/VR headset.",
        systemImage: "viewfinder",
        gradient: LinearGradient(
            gradient: Gradient(colors: [Color.indigo, Color.cyan]),
            startPoint: .top,
            endPoint: .bottom
        )
    ),
    (
        title: "Thank You for Joining WWDC 2025",
        subtitle: "Stay inspired, stay innovative, and see you next year!",
        systemImage: "sparkles",
        gradient: LinearGradient(
            gradient: Gradient(colors: [Color.purple, Color.yellow]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    )
]
