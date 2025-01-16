//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/11/25.
//

import SwiftUI

struct Level4: View {
    @EnvironmentObject var level4Data: Level4Data
    @EnvironmentObject var data: ProjectData
    var body: some View {
        GeometryReader{geo in
            let size = geo.size
            if !level4Data.showDecrypt{
               
                    Level4InfoView {
                        self.level4Data.showDecrypt = true
                    }
                    .modifier(MacBackgroundStyle(size:.init(width:size.width / 1.5,height: size.height / 1.5),movable: true,swipe:{
                        self.data.swipeWindow(.level4Decoder)
                    }){
                        self.data.closeWindow(.level4Decoder)
                    })
                
            }else{
                Level4DecryptView(size: .init(width:size.width / 2,height: size.height / 1.2))
                    .modifier(MacBackgroundStyle(size:.init(width:size.width / 2,height: size.height / 1.2),movable: true,swipe:{
                        self.data.swipeWindow(.level4Decoder)
                    }){
                        self.data.closeWindow(.level4Decoder)
                    })
            }
            
            
        }
    }
}

#Preview {
    Level4()
        .environmentObject(Level4Data())
}
