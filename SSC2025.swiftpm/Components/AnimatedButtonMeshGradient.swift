//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/12/25.
//

import SwiftUI

struct AnimatedButtonMeshGradient: View {
    let text:String
    var image:Image?
    var action:()->Void
    
    
    @State private var rotation = 0.0
    let color = Color.cyan
    var body: some View {
        Button{
            action()
        }label: {
            ZStack{
                RoundedRectangle(cornerRadius: 20,style:.continuous)
                    .stroke(color.opacity(0.3),lineWidth: 3)
                   
                
                RoundedRectangle(cornerRadius: 20,style: .continuous)
                   
                    .foregroundStyle(LinearGradient(colors: [color.opacity(0.4),color,color,color.opacity(0.4)], startPoint: .top, endPoint: .bottom))
                    .rotationEffect(.degrees(rotation))
                    .mask(RoundedRectangle(cornerRadius: 20,style:.continuous)
                        .stroke(lineWidth: 3)
                       
                        
                    )
                HStack (spacing:10){
                    if let image {
                        image
                    }
                    Text(text)
                }
                .font(.headline)
                .bold()
                .padding()
                .padding(.horizontal,30)
                .foregroundStyle(.white)
                
               
            }
            .fixedSize()
            .onAppear {
                withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)){
                    rotation = 360
                }
            }
               
            
        }
       
    }
}

#Preview {
    AnimatedButtonMeshGradient(text: "Copy Password", action:{})
}
