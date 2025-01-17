//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/18/25.
//

import SwiftUI

struct BackgroundSelectVIew: View {
    @EnvironmentObject var data:ProjectData
    let sizeOfScreen:CGSize
    var body: some View {
        GeometryReader{ geo in
            let screen = geo.size
            let size = screen.width / 2.5
            ScrollView{
                MasonryLayout(columns: 2,spacing: 10){
                    ForEach(BackgroundImages.allCases ,id:\.rawValue){background in
                        let isSelected = data.selectedBackground == background
                        
                        HStack{
                            background.image
                                .resizable()
                                .scaledToFit()
                            
                                .clipShape(RoundedRectangle(cornerRadius: size / 11,style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: size / 11,style: .continuous)
                                        .stroke(isSelected ? Color.accentColor: Color.gray, lineWidth: isSelected ? 4:2) // You can customize the color and width of the stroke
                                )
                            
                            
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            
                            withAnimation(.easeInOut){
                                
                                self.data.selectedBackground = background
                                
                            }
                        }
                        
                        
                    }
                    
                }
                .padding()
                
            }
            
            
        }
        .modifier(MacBackgroundStyle(size:.init(width:sizeOfScreen.width / 2,height: sizeOfScreen.height / 1.5), title: "Select Wallpaper", movable: true,close:{

            self.data.closeWindow(.backgroundSelect)
        }))
        
    }
}

#Preview {
    BackgroundSelectVIew(sizeOfScreen: UIScreen.main.bounds.size)
        .environmentObject(ProjectData())
}
