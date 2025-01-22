//
//  File.swift
//  SSC2025
//
//  Created by aplle on 1/5/25.
//

import SwiftUI

struct MacBackgroundStyle:ViewModifier{
    let size:CGSize
    var title:String = ""
    var movable:Bool = false
    var alignment:Alignment = .center
    @State private var offset:CGSize = .zero
    @State private var lastoffset:CGSize = .zero
    
    var swipe:(()->Void)?
    var close:()->Void
    
    func body(content: Content) -> some View {
        let gesture = movable ? DragGesture()
                            .onChanged { value in
            
                                handleDragGesture(value: value)
                            }
                            .onEnded({ value in
            
                                lastoffset = self.offset
            
                            }): nil
                    
        content
            .frame(width:size.width ,height: size.height ,alignment:alignment)
        .safeAreaInset(edge: .top){
            HStack{
                Button{
                    close()
                }label: {
                    Circle()
                        .frame(width: 20,height: 20)
                        .foregroundColor(.red)
                }
                Button{
                    if let swipe{
                        swipe()
                    }else{
                        close()
                    }
                }label: {
                    Circle()
                        .frame(width: 20,height: 20)
                        .foregroundColor(.yellow)
                }
                Button{
                    
                }label: {
                    Circle()
                        .frame(width: 20,height: 20)
                        .foregroundColor(.green)
                }
                
                if title != ""{
                    Text(title)
                        .fontWeight(.bold )
                        .padding(.leading)
                }
                Spacer()
            }
            .padding([.leading,.top,.bottom])
            .frame(width:size.width)
            .background(.ultraThickMaterial)
            
        }
        .background(.thickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 1)
        }
        
        .shadow(radius: 10)
        
        .offset(x:offset.width,y:offset.height)
        .gesture(
            gesture
        )
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: alignment)
        .padding()
    }
    func handleDragGesture(value: DragGesture.Value) {
        
        self.offset.width = value.translation.width + lastoffset.width
        self.offset.height = value.translation.height + lastoffset.height

        
    }
}
