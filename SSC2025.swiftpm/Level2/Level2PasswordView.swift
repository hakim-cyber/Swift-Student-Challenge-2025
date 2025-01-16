//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/7/25.
//

import SwiftUI

struct Level2PasswordView: View {
    let password:String = "5FC@WWDC"
    @State private var enteredPassword = ""
    let size:CGSize
    var sent:()->Void
    var body: some View {
       
          
                VStack(spacing:25){
                    VStack{
                        Image(systemName: "document.fill")
                            .resizable()
                            .foregroundStyle(.white)
                            .overlay(alignment:.bottom){
                                Group{
                                    if enteredPassword != password {
                                        Image(systemName: "lock.fill")
                                            .font(Font.system(size: 25))
                                            .bold()
                                            .foregroundStyle(.black)
                                    }else{
                                        Image(systemName: "lock.open.fill")
                                            .font(Font.system(size: 25))
                                            .bold()
                                            .foregroundStyle(.black)
                                        
                                    }
                                }
                                .padding(.bottom,5)
                            }
                            .scaledToFit()
                            .frame(width: 50)
                    }
                    .opacity(0.7)
                       
                    VStack(spacing:5){
                        Text("Attendee Database is \( enteredPassword == password ? "Unlocked":"Locked")")
                            .font(.system(size: 20, weight: .black, design: .monospaced))
                            .foregroundStyle(Color.white)
                        Text("Enter the password to unlock.")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color.white)
                    }
                    HStack(spacing:20){
                        SecureField("Enter the  password", text: $enteredPassword)
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
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                sent()
                                print("next")
                            }
                        }
                    }
                }
                
              
            
        
    }
}

#Preview {
    Level2PasswordView(size:UIScreen.main.bounds.size){
        
    }
}
