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
        
        if data.gameSteps.rawValue > GameSteps.openMessagesApp.rawValue && self.data.showDock{
            HStack(spacing:15){
                let windows = data.dockWindows
                ForEach(windows,id:\.self){window in
                    let showCircle = self.data.isWindowOpen(window)
                    Button{
                        withAnimation{
                            self.data.openWindow(window)
                        }
                    }label:{
                        
                        switch window{
                        case .level1:
                            appIconView(image: Image(.keynote), showCircle: showCircle)
                        case .messages:
                            appIconView(image: Image(.messagesLogo), showCircle: showCircle)
                        case .level2:
                            appIconView(image: Image(.robot), showCircle: showCircle)
                        case .level3:
                            appIconView(image: Image(.terminal), showCircle: showCircle)
                        case .level4Browser:
                            appIconView(image: Image(systemName: "safari"), showCircle: showCircle)
                        case .level4Decoder:
                            appIconView(image: Image(systemName: "wifi.slash"), showCircle: showCircle)
                            
                        default:
                            EmptyView()
                            
                        }
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
            
           
        }
       
    }
    func appIconView(image:Image,showCircle:Bool)->some View{
        
        VStack{
            image
                .resizable()
                .scaledToFit()
         
                
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
