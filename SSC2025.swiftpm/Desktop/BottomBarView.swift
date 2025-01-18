//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/16/25.
//

import SwiftUI

struct BottomBarView: View {
    @EnvironmentObject var data:ProjectData
    let sizeofscreen:CGSize
    var body: some View {
        
        if !data.stopDock && data.gameSteps.rawValue > GameSteps.openMessagesApp.rawValue && self.data.showDock{
            HStack(spacing:15){
                let windows = data.dockWindows
                ForEach(windows,id:\.self){window in
                    let showCircle = self.data.isWindowOpen(window)
                   
                        
                        switch window{
                        case .level1:
                            windowButton(window:window){
                                appIconView(image: Image(.keynote), showCircle: showCircle)
                            }
                        case .messages:
                            windowButton(window:window){
                                appIconView(image: Image(.messagesLogo), showCircle: showCircle)
                            }
                        case .level2:
                            windowButton(window:window){
                                appIconView(image: Image(.morseTool), showCircle: showCircle)
                            }
                        case .level3:
                            windowButton(window:window){
                                appIconView(image: Image(.terminal), showCircle: showCircle)
                            }
                        case .level4Browser:
                            windowButton(window:window){
                                appIconView(image: Image(systemName: "safari"), showCircle: showCircle)
                            }
                        case .level4Decoder:
                            windowButton(window:window){
                                appIconView(image: Image(systemName: "wifi.slash"), showCircle: showCircle)
                            }
                        case .mockKeynote:
                            windowButton(window:window){
                                appIconView(image: Image(.keynote), showCircle: showCircle)
                            }
                        case .mockAttendeeDatabase:
                            windowButton(window:window){
                                appIconView(image: Image(systemName: "text.document"), showCircle: showCircle)
                            }
                        default:
                            EmptyView()
                            
                        }
                    
                   
                   
                    
                    
                }
            }
            
            .frame( height:70,alignment: .leading)
            
            .frame(minWidth:sizeofscreen.width / 2.5,alignment: .leading)
            .padding(10)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 0.5)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottom)
            .transition(.move(edge: .bottom))
            .padding(10)
            .ignoresSafeArea()
           
        }
    
       
    }
    func windowButton(window: WindowType, label: @escaping () -> some View) -> some View {
        
        
        // Skip creating button for default case
        return AnyView(
            Button(action: {
                
                self.data.openWindow(window)
                
            }) {
                label()
            }
        )
    }
            
    func appIconView(image:Image,showCircle:Bool)->some View{
        
        VStack{
            image
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                
                Circle()
                    .foregroundStyle(Color.white)
                    .opacity(0.6)
                    .frame(width: 6, height: 6)
                    .transition(.scale)
                    .opacity(showCircle ? 1:0)
                
            
        }
        .animation(.easeInOut, value: showCircle)
        
       
        
    }
}

#Preview {
    let sizeofscreen = UIScreen.main.bounds.size
    BottomBarView(sizeofscreen: sizeofscreen)
        .environmentObject(ProjectData())
}
