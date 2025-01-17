//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/17/25.
//

import SwiftUI

struct CertificateBackView: View {
    let size:CGFloat
    let userName:String
    let metalicGradient = LinearGradient(
        colors: [Color.gray.opacity(0.8), Color.white, Color.gray.opacity(0.8)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
    var body: some View {
       back
    }
    var back:some View{
        ZStack {
                    // Background
            Color.black
                        .edgesIgnoringSafeArea(.all)

                    // Content
                    VStack(spacing: size / 10) {
                        Image(systemName: "applelogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: size / 10, height: size / 10)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                        VStack(spacing: size / 20) {
                            VStack{
                                Text("Congratulations!")
                                    .font(.system(size: size / 30, weight: .bold))
                                Text("You did it.")
                                    .font(.system(size: size / 30, weight: .bold))
                            }
                            
                            Text(congratText(name: userName == "" ? "Chiphre Master" : userName))
                                .font(.system(size: size / 40, weight: .medium))
                                .multilineTextAlignment(.center)
                            
                        }
                        Text("Made with ❤️ by Hakim")
                            .font(.system(size: size / 35, weight: .medium))
                    }
                    .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
                    .padding(size / 12)
                }
        .frame(width: size ,height: size)
        
        .clipShape(RoundedRectangle(cornerRadius: 0,style: .continuous))
        .background(RoundedRectangle(cornerRadius: 0,style: .continuous)  .stroke(metalicGradient,
            lineWidth: 4))
       
    }
    func congratText(name:String)->String{
        let congratText = """

\(name), I have to say—your skills saved the day. In a world where security is just as important as creativity, your ability to decode and outsmart the hackers kept WWDC safe and allowed us to focus on what truly matters—innovating. You’ve proven that sometimes, the smartest minds aren’t just the ones who build products, but those who protect them. So, thank you for your incredible work. You’ve done more than just crack codes—you’ve secured the future. We owe you one.
"""
        return congratText
    }
   
}
struct CertificateFrontView: View {
    let size:CGFloat
    let metalicGradient = LinearGradient(
        colors: [Color.gray.opacity(0.8), Color.white, Color.gray.opacity(0.8)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing)

    var body: some View {
           ZStack {
               // Background Gradient
               Color.black
               .edgesIgnoringSafeArea(.all)

               // Apple Logo and Text
               VStack(spacing: 20) {
                   Spacer()
                   Image(systemName: "applelogo")
                       .resizable()
                       .scaledToFit()
                       .frame(width: size / 4, height: size / 4)
                       .foregroundColor(.white)
                       .shadow(radius: 5)

                   Text("Cipher Master 2025")
                       .font(.system(size: size / 15, weight: .black))
                       .foregroundColor(.white)
                       .shadow(radius: 5)
                   Spacer()
                   Text("Designed by Cipher Master in California")
                                      
                       .font(.system(size: size / 45, weight: .black))
                       .foregroundStyle(metalicGradient)
                       .italic()
                       .shadow(radius: 5)
                       .padding(.bottom, size / 10)
                   
               }
           }
           .frame(width: size ,height: size)
           
           .clipShape(RoundedRectangle(cornerRadius: 15,style: .continuous))
           .background(RoundedRectangle(cornerRadius: 15,style: .continuous)  .stroke(metalicGradient,
               lineWidth: 4))
       }
    
   
}
#Preview {
    CertificateBackView(size:600, userName: "Hakim")
        .environmentObject(ProjectData())
}
