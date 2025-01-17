//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/13/25.
//

import SwiftUI

struct DesktopItemsView: View {
    @EnvironmentObject var data:ProjectData
    let sizeOFScreen:CGSize
    var body: some View {
        VStack(alignment:.trailing, spacing:25){
           
            HStack(alignment:.firstTextBaseline, spacing:25){
                if self.data.gameSteps.rawValue >= GameSteps.level1.rawValue{
                    Button{
                        if self.data.gameSteps == .level1{
                            self.data.openWindow(.level1)
                        }else{
                            // show mock keynote
                            self.data.openWindow(.mockKeynote)
                        }
                    }label:{
                        item(text: "Keynote", image: Image("keynote"),isLocked:self.data.gameSteps.rawValue < 2)
                    }
                }
                if self.data.gameSteps.rawValue >= GameSteps.level2.rawValue{
                    Button{
                        
                        self.data.openWindow(.level2)
                        
                    }label:{
                        item(text: "MorseCode.tool", image: Image(.morseTool))
                    }
                }
                    
            }
            HStack(alignment:.firstTextBaseline, spacing:25){
                if self.data.gameSteps.rawValue >= GameSteps.level3.rawValue{
                    Button{
                        self.data.openWindow(.level3)
                    }label:{
                        item(text: "Axicle Terminal", image: Image("terminal"))
                    }
                }
                if self.data.gameSteps.rawValue >= GameSteps.usersFolder.rawValue{
                    Button{
                        
                            self.data.openWindow(.usersFolder)
                        
                    }label:{
                        item(text: "Users Folder", image: Image("folder"))
                    }
                }
                    
            }
            if self.data.gameSteps == .noWifi{
            HStack(alignment:.firstTextBaseline, spacing:25){
              
                    Button{
                       
                        self.data.openWindow(.level4Decoder) 
                        
                    }label:{
                        item(text: "Level 4 Decoder", image: Image(systemName:"wifi.slash"))
                    }
                }
            }
           
        }
        .padding()
        .padding()
        .padding(.top)
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topTrailing)
    }
    func item(text:String,image:Image,isLocked:Bool = false)->some View{
        VStack{
          image
                .resizable()
                .scaledToFit()
                .foregroundStyle(.blue)
                .fontWeight(.medium)
                .frame(height: sizeOFScreen.width*0.05)
                .opacity(isLocked ? 0.7 : 1)
                .overlay {
                    if isLocked{
                        Image(systemName: "lock.fill")
                            .font(Font.system(size: 25))
                            .bold()
                            .foregroundStyle(.white)
                    }
                }
            Text(text)
                .bold()
                .foregroundStyle(.white)
                .frame(width: sizeOFScreen.width*0.06)
            
        }
    }
}

#Preview {
    DesktopItemsView(sizeOFScreen: UIScreen.main.bounds.size)
}
