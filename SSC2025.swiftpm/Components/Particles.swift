//
//  File.swift
//  SSC2025
//
//  Created by aplle on 1/7/25.
//

import SwiftUI


extension View{
    @ViewBuilder
    func particleEffect(systemImage:String,font:Font,status:Bool,activeTint:Color, inactiveTint:Color)->some View{
        self
            .modifier(ParticleModifier(systemImage: systemImage, font: font, status: status, activeTint: activeTint, inactiveTint: inactiveTint))
           
    }
}



struct Particle:Identifiable{
    var id:UUID = .init()
    var randomX:CGFloat = 0
    var randomY:CGFloat = 0
    var scale:CGFloat = 1
    var opacity:CGFloat = 1
    
    mutating func reset(){
        randomX = 0
        randomY = 0
        scale = 1
        opacity = 1
    }
}


fileprivate struct ParticleModifier: ViewModifier {
    var systemImage:String
    var font:Font
    var status:Bool
    var activeTint:Color
    var inactiveTint:Color
    
    @State private var particles:[Particle] = []
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                ZStack{
                    ForEach(particles){particle in
                        Image(systemName: systemImage)
                            .foregroundStyle(status ? activeTint:inactiveTint)
                            .scaleEffect(particle.scale)
                            .offset(x:particle.randomX,y:particle.randomY)
                            .opacity(particle.opacity)
                            .opacity(status ? 1:0)
                            .animation(.none, value:status)
                            .scaleEffect(5)
                    }
                }
            }
            .audioPlayer(audioName: "success", audioExtension: "mp3", trigger: .constant(status))
            .onAppear{
                if particles.isEmpty{
                    for _ in 1...50{
                        let particle = Particle()
                        particles.append(particle)
                    }
                }
                if !status{
                    for index in particles.indices{
                        particles[index].reset()
                    }
                }else{
                    for index in particles.indices{
                        let total:CGFloat =  CGFloat(particles.count)
                        let progress:CGFloat = CGFloat(index)/total
                        
                        let maxX:CGFloat = (progress > 0.5) ? 400:-400
                        let maxY:CGFloat = 400
                        
                        let randomx:CGFloat = ((progress > 0.5 ? progress - 0.5:progress)*maxX)
                        let randomy:CGFloat = ((progress > 0.5 ? progress - 0.5:progress)*maxY) + 35
                        
                        let randomScale:CGFloat = .random(in: 0.35 ... 1)
                        
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                            let extraRandomX:CGFloat = (progress < 0.5 ? .random(in: 0...10):.random(in:-10...0))
                            let extraRandomY:CGFloat = .random(in: 0...30)
                            
                            particles[index].randomX = randomx + extraRandomX
                            particles[index].randomY = -randomy - extraRandomY
                           
                        }
                        
                        withAnimation(.easeInOut(duration:0.3)){
                            particles[index].scale = randomScale
                        }
                        
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.25 + Double(index) * 0.005)){
                            particles[index].scale = 0.001
                        }
                    }
                }
            }
            .onChange(of: status) { oldValue, newValue in
                if !newValue{
                    for index in particles.indices{
                        particles[index].reset()
                    }
                }else{
                    for index in particles.indices{
                        let total:CGFloat =  CGFloat(particles.count)
                        let progress:CGFloat = CGFloat(index)/total
                        
                        let maxX:CGFloat = (progress > 0.5) ? 400:-400
                        let maxY:CGFloat = 600
                        
                        let randomx:CGFloat = ((progress > 0.5 ? progress - 0.5:progress)*maxX)
                        let randomy:CGFloat = ((progress > 0.5 ? progress - 0.5:progress)*maxY) + 350
                        
                        let randomScale:CGFloat = .random(in: 0.35 ... 1)
                        
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                            let extraRandomX:CGFloat = (progress < 0.5 ? .random(in: 0...10):.random(in:-400...0))
                            let extraRandomY:CGFloat = .random(in: 0...300)
                            
                            particles[index].randomX = randomx + extraRandomX
                            particles[index].randomY = -randomy - extraRandomY
                           
                        }
                        
                        withAnimation(.easeInOut(duration:0.3)){
                            particles[index].scale = randomScale
                        }
                        
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.25 + Double(index) * 0.005)){
                            particles[index].scale = 0.001
                        }
                    }
                }
            }
    }
}
