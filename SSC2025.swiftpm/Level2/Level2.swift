//
//  SwiftUIView 2.swift
//  SSC2025
//
//  Created by aplle on 1/7/25.
//

import SwiftUI

struct Level2: View {
    @EnvironmentObject var level2Data: Level2Data
    @EnvironmentObject var data:ProjectData
    var finished:()->Void
    var body: some View {
        GeometryReader{geo in
            let size = geo.size
            ZStack {
               
                Level2MainDecryptView(size: .init(width:size.width / 1.5,height: size.height / 1.2), showInstructions: $level2Data.solved)
                
            }
            .onChange(of: level2Data.solved, { oldValue, newValue in
                if newValue{
                    self.finished()
                }
            })
            .modifier(MacBackgroundStyle(size:.init(width:size.width / 1.5,height: size.height / 1.4),title:"Level 2", movable: level2Data.solved,showInfo: true,swipe:{
               
                    data.swipeWindow(.level2)
                
               
                
            },openInfo: {
                self.data.openWindow(.chiphreInfo)
            }){
              
               
                    self.data.closeWindow(.level2)
                
            })
        }
    }
}

#Preview {
    Level2{
        
    }
}
