//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/13/25.
//

import SwiftUI

struct DesktopView: View {
    @EnvironmentObject var data: ProjectData
    var body: some View {
        GeometryReader{geo in
            let size = geo.size
            
               
                    ZStack{
                        Image("desktop")
                            .resizable()
                            .ignoresSafeArea()
                            .zIndex(-1)
                      
                        DesktopItemsView(sizeOFScreen: size)
                            .zIndex(0)
                        ForEach(data.openWindows, id: \.self) { window in
                            switch window {
                            case .level1:
                                Level1View {
                                
                                  
                                    if self.data.gameSteps == .level1{
                                        self.data.gameSteps = .level2
                                    }
                                }
                                .zIndex(Double(data.openWindows.firstIndex(of: .level1) ?? 0))
                                .onTapGesture {
                                    data.bringToFront(.level1)
                                }
                            case .level2:
                                Level2{
                                   
                                    if self.data.gameSteps == .level2{
                                        self.data.gameSteps = .usersFolder
                                    }
                                    
                                }
                                .zIndex(Double(data.openWindows.firstIndex(of: .level2) ?? 0))
                                .onTapGesture {
                                    data.bringToFront(.level2)
                                }
                            case .level3:
                                Level3(){
                                   
                                    if self.data.gameSteps == .level3{
                                        
                                        self.data.gameSteps = .level4
                                    }
                                }
                                .zIndex(Double(data.openWindows.firstIndex(of: .level3) ?? 0))
                                .onTapGesture {
                                    data.bringToFront(.level3)
                                }
                            case .level4Browser:
                                Level4NoInternet {
                                    self.data.gameSteps = .noWifi
                                    self.data.closeWindow(.level4Browser)
                                }
                                .modifier(MacBackgroundStyle(size: .init(width: size.width / 1.5, height: size.height / 1.5),title:"https://developer.apple.com/wwdc/2025", movable: true, swipe: {
                                    if self.data.gameSteps == .level4{
                                        self.data.gameSteps = .noWifi
                                    }
                                    self.data.swipeWindow(.level4Browser)
                                }, close: {
                                    self.data.gameSteps = .noWifi
                                    self.data.closeWindow(.level4Browser)
                                    
                                }))
                                .zIndex(Double(data.openWindows.firstIndex(of: .level4Browser) ?? 0))
                                .onTapGesture {
                                    data.bringToFront(.level4Browser)
                                }
                            case .level4Decoder:
                                Level4()
                                    .zIndex(Double(data.openWindows.firstIndex(of: .level4Decoder) ?? 0))
                                    .onTapGesture {
                                        data.bringToFront(.level4Decoder)
                                    }
                            case .level4Wifi:
                                WifiPasswordView()
                                    .modifier(MacBackgroundStyle(size: .init(width: size.width / 1.8, height: size.height / 2), movable: true, swipe: {
                                        
                                    }, close: {
                                        
                                        self.data.closeWindow(.level4Wifi)
                                    }))
                                .zIndex(Double(data.openWindows.firstIndex(of: .level4Wifi) ?? 0))
                                .onTapGesture {
                                    data.bringToFront(.level4Wifi)
                                }
                            case .messages:
                                MessagesView(sizeofScreen: size)
                                    .zIndex(Double(data.openWindows.firstIndex(of: .messages) ?? 0))
                                    .onTapGesture {
                                        data.bringToFront(.messages)
                                    }
                            case .usersFolder:
                                Level2FolderView(size: size) {
                                  
                                   
                                    if self.data.gameSteps == .usersFolder{
                                        self.data.gameSteps = .level3
                                    }
                                    
                                }
                                .zIndex(Double(data.openWindows.firstIndex(of: .usersFolder) ?? 0))
                                .onTapGesture {
                                    data.bringToFront(.usersFolder)
                                }
                            case .aboutMac:
                                AboutThisMacView()
                                   
                                    .modifier(MacBackgroundStyle(size: .init(width: size.width / 3.5, height: size.height / 1.7), movable: true, close: {
                                      
                                        self.data.closeWindow(.aboutMac)
                                    }))
                                    .zIndex(Double(data.openWindows.firstIndex(of: .aboutMac) ?? 0))
                                    .onTapGesture {
                                        data.bringToFront(.aboutMac)
                                    }
                            default:
                                EmptyView()
                            }
                            
                        }
                       
                      
                        BottomBarView(sizeofscreen: size)
                            .zIndex(9)
                       
                        NotificationsView(sizeOFScreen: size)
                            .zIndex(10)
                    }
               .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
               .safeAreaInset(edge: .top) {
                   MacToolbar(sizeOFScreen: size)
                       .zIndex(12)
               }
               .overlay {
                   if self.data.showWWDCAnimation{
                       WWDCAnimationView{
                           self.data.showWWDCAnimation = false
                           self.data.gameSteps = .watchedAnimation
                       }
                   }
               }
        }
    }
}

#Preview {
    DesktopView()
        .environmentObject(ProjectData())
}
