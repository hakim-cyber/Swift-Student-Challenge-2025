//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/13/25.
//

import SwiftUI

struct MessagesView: View {
    @EnvironmentObject var data:ProjectData
   
    let sizeofScreen:CGSize
    var body: some View {
       
            ZStack{
                
                ScrollViewReader{scroll in
                    ScrollView(.vertical){
                        VStack(spacing: 20){
                            Text((Date.now).formatted(date: .abbreviated, time: .shortened))
                                .foregroundStyle(.secondary)
                            ForEach($data.messages){$message in
                                MessageBubble(message: $message, sizeOFScreen:.init(width: sizeofScreen.width / 2.2, height: sizeofScreen.height / 1.2))
                            }
                            if !data.messageQueue.isEmpty{
                                TypingAnimation()
                                    .id(data.messages.count)
                            }
                            Color.clear.frame(height:50)
                                .id("space")
                        }
                        .onChange(of: data.messages) { oldValue, newValue in
                            
                            scroll.scrollTo("space")
                            
                        }
                    }
                    .onAppear {
                        scroll.scrollTo("space")
                    }
                   
                }
                
            }
            .modifier(MacBackgroundStyle(size: .init(width: sizeofScreen.width / 2.3, height: sizeofScreen.height / 1.5),title: "To: Steve Jobs Assistant", movable: true,alignment: .leading,swipe:{
                self.data.swipeWindow(.messages)
            }, close: {
                self.data.swipeWindow(.messages)
            }))
            
            .onAppear {
                
                if self.data.gameSteps == .openMessagesApp{
                    self.data.gameSteps = .level1
                   
                }
                
            }
    }
}

#Preview {
    MessagesView(sizeofScreen: UIScreen.main.bounds.size)
        .environmentObject(ProjectData())
}
