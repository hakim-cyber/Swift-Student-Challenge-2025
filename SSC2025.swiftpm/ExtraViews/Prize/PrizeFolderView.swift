//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/17/25.
//

import SwiftUI

struct PrizeFolderView: View {
    let size:CGSize
    @EnvironmentObject var data:ProjectData
    var body: some View {
        let windowSize = CGSize(width:size.width / 2,height:size.height / 2)
        ZStack{
            HStack(spacing:20){
                Button{
                    
                    // open certificates preview view
                }label:{
                    VStack{
                        Image(.certificate)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                        Text("Certificates.png")
                            .bold()
                            .foregroundStyle(.white)
                            .frame(width: 140)
                        
                    }
                    
                    
                }
                Button{
                    
                    
                }label:{
                    VStack{
                        Image(.certificate)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                        Text("Trophy.3D")
                            .bold()
                            .foregroundStyle(.white)
                            .frame(width: 140)
                        
                    }
                    
                    
                }
            }
            
        }
        .modifier(MacBackgroundStyle(size: windowSize, title: "Prizes", movable: true ,close: {
           
             
               
            
        }))
    }
}

#Preview {
    PrizeFolderView(size: UIScreen.main.bounds.size)
}
