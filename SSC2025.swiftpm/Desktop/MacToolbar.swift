//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/13/25.
//

import SwiftUI

struct MacToolbar: View {
    @EnvironmentObject var data:ProjectData
    let sizeOFScreen: CGSize
    
    @State private var showCenterPopOver: Bool = false
    var body: some View {
       
            
                HStack(spacing:20){
                    Menu{
                        Button("About This Mac"){
                            self.data.openWindow(.aboutMac)
                        }
                        Divider()
                        if self.data.gameSteps.rawValue < GameSteps.noWifi.rawValue{
                            Button("Finish Story"){
                                self.data.finishGameStep()
                            }
                           
                        }
                        Button("Log Out"){
                            self.data.startSteps = .intro
                        }
                       
                            
                        
                    }label:{
                        
                        Image(systemName: "apple.logo")
                        
                    }
                    Menu{
                        Button("About This Mac"){
                            self.data.openWindow(.aboutMac)
                        }
                        Divider()
                        if self.data.gameSteps.rawValue < GameSteps.noWifi.rawValue{
                            Button("Finish Story"){
                                self.data.finishGameStep()
                            }
                           
                        }
                        Button("Log Out"){
                            self.data.startSteps = .intro
                        }
                       
                            
                    }label:{
                        
                        Text("Chiphre Master")
                            .fontWeight(.heavy)
                        
                    }
                    
                    Menu("File"){
                        Button("New Finder Window"){
                            
                        }
                        .disabled(true)
                        Button("New Folder"){
                            
                        }
                        .disabled(true)
                    }
                    Menu("Window"){
                        Button("Minimize"){
                            
                        }
                        .disabled(true)
                        Button("Zoom"){
                            
                        }
                        .disabled(true)
                    }
                    Button("Help"){
                        self.data.openWindow(.chiphreInfo)
                    }
                    Spacer()
                    Image(systemName: "battery.100percent")
                        .foregroundStyle(.white, .secondary)
                    Button{
                        if self.data.gameSteps == .noWifi{
                            self.data.openWindow(.level4Wifi)
                        }
                    }label: {
                        if data.gameSteps.rawValue >= GameSteps.connectedToWifi.rawValue{
                            Image(systemName: "wifi")
                                .foregroundStyle(.white)
                        }else{
                            if self.data.gameSteps == .noWifi && !self.data.isWindowOpen(.level4Wifi){
                                Image(systemName: "wifi")
                                    .modifier(ShiningEffect(systemColor: .secondary, shadowColor: .yellow))
                            }else{
                                Image(systemName: "wifi")
                                    .foregroundStyle(.secondary)
                            }
                          
                        }
                    }
                   
                   
                    Image(systemName: "magnifyingglass")
                   
                    Button{
                        self.showCenterPopOver.toggle()
                    }label: {
                        Image(systemName: "switch.2")
                    }
                    .popover(isPresented: $showCenterPopOver, attachmentAnchor: .point(.bottom)) {
                        ControlCenterView(size:sizeOFScreen){
                            self.showCenterPopOver = false
                        }
                            .presentationBackground(.clear)
                            .environmentObject(self.data)
                    }
                    Text((Date.now).formatted(date: .abbreviated, time: .shortened))
                }
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .padding(.horizontal)
                .frame(width: sizeOFScreen.width, height: sizeOFScreen.height/55,alignment: .leading)
                .padding(.vertical,10)
                .background(Color.gray.opacity(0.1))
                .background(Color.black)
               
            
        
    }
}

#Preview {
    MacToolbar(sizeOFScreen:UIScreen.main.bounds.size)
}
