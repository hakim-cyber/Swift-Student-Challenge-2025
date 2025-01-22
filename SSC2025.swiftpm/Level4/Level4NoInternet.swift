//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/11/25.
//

import SwiftUI

struct Level4NoInternet: View {
    @State private var tryagain: Bool = false
    var showInfoView:()->Void
    var body: some View {
        let text1 = """
You Are Not Connected to the
Internet
"""
        let text2 = """
This page can't be displayed because your computer is currently
offline.
"""
        if tryagain{
            ProgressView()
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                        self.showInfoView()
                    }
                }
        }else{
            VStack(spacing: 20){
                Text(text1)
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .fontWeight(.black)
                Text(text2)
                    .multilineTextAlignment(.center)
                    .fontWeight(.medium)
                Button(action: {
                    
                    tryagain = true
                }) {
                    Text("Try Again")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                        .foregroundColor(Color.blue)
                    
                }
                .padding(.horizontal)
                .fixedSize()
            }
        }
    }
}

#Preview {
    let size = UIScreen.main.bounds.size
   return Level4NoInternet{
        
    }
        .modifier(MacBackgroundStyle(size: .init(width: size.width / 1.2, height: size.height / 1.2),title:"https://developer.apple.com/wwdc/2025", close: {
            
        }))
}
