//
//  NotificationsView.swift
//  SSC2025
//
//  Created by aplle on 1/13/25.
//

import SwiftUI

struct NotificationsView: View {
    @EnvironmentObject var data:ProjectData
    let sizeOFScreen:CGSize
    @State var showAlert:Bool = false
    var body: some View {
        VStack{
            ForEach(data.notifications){notification in
                HStack{
                    notification.type.image
                       
                    VStack(alignment: .leading,spacing: 2){
                        HStack{
                            switch notification.type{
                            case .tip:Text("Tip")
                                    .fontWeight(.heavy )
                            case .message:Text("Message")
                                    .fontWeight(.heavy )
                            }
                            Spacer()
                            Text("\(notification.date.formatted(date:.omitted, time: .shortened))")
                        }
                        
                        Text(notification.text)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                   
                }
                .frame(width: sizeOFScreen.width / 3.5)
                .fixedSize(horizontal: false, vertical: true)
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15))
               
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
            }
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topTrailing)
        .animation(.easeInOut, value:data.notifications)
        .audioPlayer2(audioName: "notification", audioExtension: "m4a", trigger: $showAlert)
        .onChange(of: data.notifications.count, { oldValue, newValue in
            if oldValue<newValue{
                self.showAlert = true
            }
            
        })
        .onTapGesture(perform: {
            if self.data.gameSteps == .openMessagesApp{
                self.data.openWindow(.messages)
             
            }
            self.data.notifications.removeAll()
        })
        .onAppear{
           
            self.data.notifications.append(NotificationStruct(text: "“Urgent Message from Steve Jobs’ Assistant! Tap here to open Messages.”",type:.message))
            
          
            
        }
        
    }
}

#Preview {
    NotificationsView(sizeOFScreen:UIScreen.main.bounds.size)
        .environmentObject(ProjectData())
}

struct NotificationStruct:Identifiable,Equatable{
    var id : UUID = UUID()
    var date: Date = Date()
    var text: String
    var type: NotificationType = .tip
}
enum NotificationType{
    case tip,message
    
    var image:some View{
        Group{
            switch self{
            case .tip:
                Image(systemName: "lightbulb.fill")
                    .font(.system(size: 30))
                    .foregroundStyle(.yellow)
            case .message:
                Image("messages.logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    
            }
        }
    }
}

