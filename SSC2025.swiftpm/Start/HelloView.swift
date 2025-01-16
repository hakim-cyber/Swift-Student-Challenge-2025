//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/12/25.
//

import SwiftUI

struct HelloView: View {
    var next:()->Void
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Image("desktop")
                    .resizable()
                
                    .ignoresSafeArea()
                
                VStack(spacing:20){
                    Spacer()
                    HelloAnimation()
                        .frame(width: geo.size.width / 2,height: geo.size.width / 4)
                        .transition(.identity)
                        .id(geo.size)
                    Spacer()
                    Button{
                        next()
                    }label:{
                        VStack {
                            Image(systemName: "arrow.right")
                                .padding(10)
                                .font(.system(size: 20))
                                .background(Circle().stroke(.white,lineWidth: 8))
                                .clipShape(Circle())
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .contentShape(Rectangle())
                            
                            Text("Get Started")
                                .foregroundColor(.white)
                                .padding(.top, 4)
                                .fontWeight(.heavy)
                                .font(.system(size: 22))
                            
                            
                        }
                    }
                    
                }
                .padding(60)
            }
        }
    }
}

#Preview {
    HelloView{
        
    }
}
