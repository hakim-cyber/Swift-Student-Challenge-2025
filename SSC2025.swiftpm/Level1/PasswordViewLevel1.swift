//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/5/25.
//

import SwiftUI

struct PasswordViewLevel1: View {
    let password:String = "5FC@WWDC"
    @State private var enteredPassword = ""
    let size:CGSize
    var next:()->Void
    
    var body: some View {
       
          
                VStack(spacing:25){
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 50,height: 50)
                        .foregroundStyle(Color.white)
                        .opacity(0.8)
                        .overlay {
                            if enteredPassword != password {
                                Image(systemName: "lock.fill")
                                    .font(Font.system(size: 25))
                                    .bold()
                            }else{
                                Image(systemName: "lock.open.fill")
                                    .font(Font.system(size: 25))
                                    .bold()
                                  
                            }
                        }
                    VStack(spacing:5){
                        Text("Keynote is \( enteredPassword == password ? "Unlocked":"Locked")")
                            .font(.system(size: 20, weight: .black, design: .monospaced))
                            .foregroundStyle(Color.white)
                        Text("Enter the decrypted password to unlock.")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color.white)
                    }
                    HStack(spacing:20){
                        SecureField("Enter the decrypted password", text: $enteredPassword)
                            .padding(10)
                            .foregroundStyle(Color.white)
                        
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay{
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(enteredPassword == password ? Color.cyan : Color.red,lineWidth: 3)
                            }
                            .frame(width: size.width / 5)
                        Button{
                            withAnimation(.bouncy){
                                self.enteredPassword = password
                            }
                        }label: {
                            Image(systemName: "document.on.clipboard.fill")
                                .foregroundStyle(.white)
                        }
                    }
                    if  self.enteredPassword == password{
                        FlyingBirdButton {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                next()
                                print("next")
                            }
                        }
                    }
                }
                
              
            
        
    }
}
//
//#Preview {
//    PasswordViewLevel1()
//}
