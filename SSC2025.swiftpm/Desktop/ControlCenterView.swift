//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/18/25.
//

import SwiftUI

struct ControlCenterView: View {
   
    @EnvironmentObject var data:ProjectData
   
    let size:CGSize
    var close:()->()
    var body: some View {
        VStack(spacing:20){
            HStack{
                let selected = data.selectedBackground
                let sizeofImage = size.width / 15
                Button{
                    self.data.openWindow(.backgroundSelect)
                    self.close()
                    
                }label:{
                    HStack(spacing:20){
                        selected.image
                            .resizable()
                        
                            .scaledToFill()
                            .frame(width: sizeofImage,height:sizeofImage)
                        
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        VStack(alignment:.leading, spacing:10){
                            Text(selected.name)
                                .fontWeight(.heavy)
                            Text("Dynamic Wallpaper")
                                .bold()
                        }
                        Spacer()
                    }.modifier(MacToolbarBackgroundStyle())
                }
            }
            HStack{
                Text("Hide Dock")
                Image(systemName: "dock.rectangle")
                Spacer()
                Toggle("", isOn: $data.stopDock)
                    .labelsHidden()
            }
           
            .modifier(MacToolbarBackgroundStyle())
            
            
        }
        .padding()
        
        .frame(width: size.width / 3)
        
       
    }
}

#Preview {
    ControlCenterView(size: UIScreen.main.bounds.size){
        
    }
        .environmentObject(ProjectData())
}


struct MacToolbarBackgroundStyle: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .padding(15)
            .background{
                
                RoundedRectangle(cornerRadius: 12).fill(.black.opacity(0.3)).stroke(.gray, lineWidth: 0.5)
               
                }
    }
}

enum BackgroundImages:String, CaseIterable,Equatable{
    case proBlack,sequoia,sonoma,ventura,bigsur,mojave
      
    
    var name:String{
        switch self{
        case .proBlack:
            return "Pro Black"
        
        case .sequoia:
            return "Sequoia"
        case .sonoma:
            return "Sonoma"
        case .ventura:
            return "Ventura"
        case .bigsur:
            return "Big Sur"
        case .mojave:
            return "Mojave"
        }
    }
    var image:Image{
        switch self {
        case .proBlack:
            Image(.desktop)//change it
        case .sequoia:
            Image(.sequoia)
        case .sonoma:
            Image(.sonoma)
        case .ventura:
            Image(.ventura)
        case .bigsur:
            Image(.bigSur)
        case .mojave:
            Image(.mojave)
        }
    }
    
    
}
