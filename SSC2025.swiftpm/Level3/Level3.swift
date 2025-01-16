//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/9/25.
//

import SwiftUI

struct Level3: View {
    @EnvironmentObject var data:ProjectData
    var close:()->Void
    var body: some View {
        GeometryReader{geo in
            let size = geo.size
            if data.showedInfoAxicle{
                
                
                Level3MainDecryptView(size: size,close: close)
            }else{
                Level3InfoView {
                    self.data.showedInfoAxicle = true
                }
                .modifier(MacBackgroundStyle(size:.init(width:size.width / 1.5,height: size.height / 1.5), movable: true){
                 
                })
            }
        }
    }
}

#Preview {
    Level3(){
        
    }
        .environmentObject(ProjectData())
}
