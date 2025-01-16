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
    
   let colors1 =  (0...9).map{_ in
       [Color.accentColor,Color.red,Color.blue,Color.green,].randomElement()!}
    let colors2 =  (0...9).map{_ in
        [Color.yellow,Color.purple,Color.orange].randomElement()!}
    @State private var animated = false
    
    var body: some View {
        Button{
            action()
        }label: {
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
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(
                            MeshGradient(width: 3, height: 3, points: [
                                .init(x: 0, y: 0),.init(x: 0.5, y: 0),.init(x: 1, y: 0),
                                .init(x: 0, y: 0.5),.init(x: 0.5, y: 0.5),.init(x: 1, y: 0.5),
                                .init(x: 0, y: 1),.init(x: 0.5, y: 1),.init(x: 1, y: 1)
                            ], colors: animated ? colors1 : colors2)
                            
                            
                            ,lineWidth: 7)
                    
                    
                )
                
                .clipShape(.rect(cornerRadius: 40))
                .onAppear {
                    withAnimation(.easeInOut(duration: 2).repeatForever()){
                        self.animated.toggle()
                    }
                }
               
            
        }
        .id(text)
    }
}

#Preview {
    AnimatedButtonMeshGradient(text: "Copy Password", action:{})
}
