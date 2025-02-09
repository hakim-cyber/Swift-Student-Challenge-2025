//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/5/25.
//

import SwiftUI

struct Level1View: View {
    @State private var step:Level1Steps = .welcome
    @EnvironmentObject var level1Data:Level1Data
    @EnvironmentObject var data:ProjectData
    var finished:()->Void
    var body: some View {
        GeometryReader{geo in
            let size = geo.size
            ZStack {
                if !self.level1Data.sentTheMessage{
                    switch step {
                    case .welcome:
                        Level1WelcomeView{
                            withAnimation(.bouncy){
                                self.step = .encypt
                            }
                        }
                    case .encypt:
                        Level1Main(size:size){
                            withAnimation(.bouncy){
                                self.step = .send
                            }
                        } back:{
                            withAnimation(.bouncy){
                                self.step = .welcome
                            }
                        }
                        
                    case .send:
                        PasswordViewLevel1(size:size){
                            self.level1Data.sentTheMessage = true
                            finished()
                            self.data.closeWindow(.level1)
                           
                        }
                    }
                }else{
                    Text("Close the Window")
                        .font(.system(size: 18, weight: .black, design: .monospaced))
                        .foregroundStyle(Color.white)
                        .padding()
                      
                }
            }
        
          
            .modifier(MacBackgroundStyle(size:.init(width:size.width / 2,height: size.height / 1.5), movable: self.step != .encypt,showInfo: true,swipe: {
                
                    data.swipeWindow(.level1)
                
                    
            },openInfo: {
                self.data.openWindow(.chiphreInfo)
            }, close:{
                
                self.data.closeWindow(.level1)
                
            }))
         
        }
        
    }
}

#Preview {
    Level1View{
        
    }
}
enum Level1Steps:Int{
    case welcome,encypt,send
}
