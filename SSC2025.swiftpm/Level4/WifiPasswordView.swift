//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/11/25.
//

import SwiftUI

struct WifiPasswordView: View {
    @EnvironmentObject var data:ProjectData
    @State private var passwordInput: String = ""
    @State private var showPassword = false
    let correctPassword = "Stay Hungry, Stay Foolish"
    @FocusState var focused:Bool
    
    @State var truePassword:Bool = false
    @State var showAlert:Bool = false
    @State private var animateWrongText = false
    @State private var checkAttempt = false
    var body: some View {
        let text1 = """
The Wi-Fi network “Apple_Events_Live” requires a
WPA2 password.
"""
        let text2 = """
You can also access this Wi-Fi network by sharing the password from a nearby iPhone, iPad, or Mac which has connected to this network and has you in their contacts.
"""
        VStack{
            HStack(alignment:.top, spacing: 25){
                Image(systemName: "wifi")
                    .resizable()
                    .foregroundStyle(.blue)
                    .scaledToFit()
                    .frame(width: 80)
                    .padding(.top,5)
                
                
                VStack(alignment:.leading, spacing: 25){
                    VStack(alignment:.leading, spacing: 15){
                        Text(text1)
                            .font(.title3)
                            .fontWeight(.heavy)
                        Text(text2)
                            .fontWeight(.medium)
                    }
                    HStack (alignment:.firstTextBaseline, spacing: 15){
                        Text("Password:")
                            .fontWeight(.medium)
                        VStack(alignment: .leading,spacing:10){
                            
                            if showPassword{
                                TextField("Enter Password", text: $passwordInput)
                                    .padding(.horizontal,5)
                                    .padding(.vertical,2)
                                    .background(.regularMaterial)
                                    .background(Rectangle().stroke(.blue,lineWidth:focused ? 1 : 0))
                                    .padding(.trailing,20)
                                    .focused($focused)
                            }else{
                                SecureField("Enter Password", text: $passwordInput)
                                    .padding(.horizontal,5)
                                    .padding(.vertical,2)
                                    .background(.regularMaterial)
                                    .background(Rectangle().stroke(.blue,lineWidth:focused ? 1 : 0))
                                    .padding(.trailing,20)
                                    .focused($focused)
                            }
                            
                            HStack{
                                CheckmarkStyleToggle(value: $showPassword)
                                Text("Show Password")
                            }
                            
                        }
                        
                        Button{
                            withAnimation(.bouncy){
                                if let paste = UIPasteboard.general.string{
                                    self.passwordInput = paste
                                }
                            }
                        }label: {
                            Image(systemName: "document.on.clipboard.fill")
                                .foregroundStyle(.white)
                        }
                        
                    }
                    .particleEffect(systemImage: "star.fill", font: .title2, status: truePassword, activeTint: .yellow, inactiveTint: .secondary)
                    
                    
                }
            }
            Spacer()
            HStack(spacing:25){
                if showAlert{
                    HStack{
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(.yellow)
                        Text("Incorrect Password")
                    }
                }
                Spacer()
                Button{
                    self.data.closeWindow(.level4Wifi)
                }label:{
                    Text("Cancel")
                        .foregroundStyle(.white)
                        .bold()
                        .padding(5)
                        .padding(.horizontal)
                        .background(Color.init(uiColor: .systemGray2))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                if checkAttempt{
                    ProgressView()
                }else{
                    Button{
                        self.checkAttempt = true
                       
                        if self.passwordInput.lowercased().trimAllSpace() ==
                            
                            correctPassword.lowercased().trimAllSpace(){
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            truePassword = true
                                
                                if self.data.gameSteps == .noWifi{
                                    self.data.gameSteps = .connectedToWifi
                                    self.data.closeWindow(.level4Wifi)
                                }
                            self.checkAttempt = false
                        }
                        }else{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                self.showAlert = true
                                animateView()
                                self.checkAttempt = false
                            }
                        }
                    }label:{
                        Text("Join")
                            .foregroundStyle(.white)
                            .bold()
                            .padding(5)
                            .padding(.horizontal)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
               
            }
        }
        .offset(x:animateWrongText ? 10 : 0)
        .padding(25)
        
    }
    func animateView(){
        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.2, blendDuration: 0.2)){
            animateWrongText = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.2, blendDuration: 0.2)){
                animateWrongText = false
            }
        }
    }
}

#Preview {
    let size = UIScreen.main.bounds.size
    WifiPasswordView()
        .modifier(MacBackgroundStyle(size: .init(width: size.width / 1.8, height: size.height / 2), close: {
            
        }))
}

/*
 The Wi-Fi network "ALHN-CF22-5" requires a
 WPA2 password.
 You can also access this Wi-Fi network by sharing the password from a nearby iPhone, iPad, or Mac which has connected to this network and has you in their contacts.
 */

struct CheckmarkStyleToggle:View{
    @Binding var value: Bool
    var size:CGFloat = 20
    var body: some View {
        ZStack{
            if !value{
                RoundedRectangle(cornerRadius: size / 5)
                    .fill(Color.init(uiColor: .systemGray4))
                    .frame(width: size, height: size)
            }else{
                RoundedRectangle(cornerRadius: size / 5)
                    .fill(Color.blue)
                Image(systemName: "checkmark")
                    .resizable()
                    .scaledToFit()
                    .padding(size / 6)
                    .bold()
                
            }
            
            
        }
        .frame(width: size, height: size)
        .contentShape(Rectangle())
        .onTapGesture {
            self.value.toggle()
        }
        
    }
}


