//
//  StartView.swift
//  SSC2025
//
//  Created by aplle on 1/12/25.
//

import SwiftUI

struct NameView: View {
    @EnvironmentObject var data:ProjectData
    var done:()->Void
    var body: some View {
        ZStack{
            Image("desktop")
                .resizable()
            
                .ignoresSafeArea()
            
            VStack(spacing:20){
                VStack(spacing:0){
                    Text(String.formattedDate(from: Date.now))
                        .fontWeight(.bold)
                        .font(.system(size: 22))
                    Text(String.formattedTime24Hour(from: Date.now))
                        .fontWeight(.heavy)
                        .font(.system(size: 90))
                }
                Spacer()
                VStack {
                          
                           
                           
                    HStack(spacing:0){
                        TextField("Enter your name", text: $data.userName)
                            .padding()
                            .foregroundStyle(.white)
                           
                            .frame(width: 250)
                            .safeAreaInset(edge: .trailing) {
                                Button{
                                    done()
                                }label: {
                                    Image(systemName: "arrow.right")
                                        .padding(10)
                                        .font(.system(size: 20))
                                        .background(Circle().stroke(.white,lineWidth: 8))
                                        .clipShape(Circle())
                                        .fontWeight(.heavy)
                                        .foregroundColor(.white)
                                        .contentShape(Rectangle())
                                }
                                
                            }
                            .padding(.trailing,5)
                            .background(
                                RoundedRectangle(cornerRadius: 55)
                                    .fill(.ultraThinMaterial)
                                    .shadow(color: Color.primary.opacity(0.5), radius: 5, x: 0, y: 2)
                            )
                            .onSubmit {
                                done()
                            }
                            
                       
                    }
                           
                          
                           Text("Default name will be 'User'")
                               .foregroundColor(.white)
                               .padding(.top, 4)
                               .fontWeight(.heavy)
                               .font(.system(size: 16))
                           
                    
                       }
                       
            }
            .padding(60)
        }
    }
}

#Preview {
    NameView{
        
    }
        .environmentObject(ProjectData())
}
extension String{
    static func formattedDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter.string(from: date)
    }
    static  func formattedTime24Hour(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

}
