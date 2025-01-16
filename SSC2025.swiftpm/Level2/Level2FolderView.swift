//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/7/25.
//

import SwiftUI

struct Level2FolderView: View {
    let size:CGSize
    @EnvironmentObject var data:ProjectData
    @State private var showAttendeeFile:Bool = false
    @State private var sentFile:Bool = false
    
    var close:()->Void
    var body: some View {
        let windowSize = CGSize(width:size.width / 2,height:size.height / 2)
        ZStack{
            if !sentFile{
                if !showAttendeeFile{
                    
                    
                    Button{
                        
                        self.showAttendeeFile = true
                    }label:{
                        VStack{
                            Image(systemName: "document.fill")
                                .resizable()
                                .foregroundStyle(.white)
                                .overlay(alignment:.bottom){
                                    Text("TXT")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 15))
                                        .padding(8)
                                        .bold()
                                        .ignoresSafeArea()
                                }
                                .scaledToFit()
                                .frame(width: 50)
                            Text("Attendee Database.txt")
                                .bold()
                                .foregroundStyle(.white)
                                .frame(width: 120)
                            
                        }
                        
                        
                    }
                }else{
                    Level2PasswordView(size: windowSize){
                        sentFile = true
                        self.close()
                      
                    }
                }
            }else{
                Text("Close the Window")
            }
        }
        .modifier(MacBackgroundStyle(size: windowSize, title: showAttendeeFile ? "":"USERS", movable: true ,close: {
           
                self.data.closeWindow(.usersFolder)
               
            
        }))
    }
}

#Preview {
    Level2FolderView(size:UIScreen.main.bounds.size){
        
    }
}
