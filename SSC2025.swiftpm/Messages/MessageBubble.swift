//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/13/25.
//

import SwiftUI

struct MessageBubble: View {
    @Binding var message:MessageViewStruct
    let sizeOFScreen:CGSize
    var body: some View {
      
           
        VStack{
            switch message.messageStyle {
            case .message:
                Text(message.text)
                    .foregroundStyle(.white)
                    .bold()
                    .multilineTextAlignment(.leading)
            case .tip:
                Text(message.text)
                    .foregroundStyle(.yellow)
                    .fontWeight(.bold )
                    .multilineTextAlignment(.leading)
            case .file(let image, let string):
                HStack{
                    Spacer()
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    VStack(alignment: .leading){
                        
                        Text(message.text)
                            .foregroundStyle(.white)
                            .bold()
                            .multilineTextAlignment(.leading)
                        Text(string)
                            .foregroundStyle(.secondary)
                            
                            .multilineTextAlignment(.leading)
                        
                    }
                   
                   
                }
                .fixedSize()
            case .link(let image, let string):
                HStack{
                    VStack(alignment: .leading){
                        Text(message.text)
                            .foregroundStyle(.white)
                            .bold()
                            .multilineTextAlignment(.leading)
                        Text(string)
                            .foregroundStyle(.secondary)
                            
                            .multilineTextAlignment(.leading)
                        
                    }
                    Spacer()
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    Image(systemName: "arrow.up.forward")
                        .bold()
                        .foregroundStyle(.secondary)
                }
                .fixedSize()
            case .congratulations:
                Text(message.text)
                    .foregroundStyle(.white)
                    .fontWeight(.black)
                    .multilineTextAlignment(.leading)
                    .modifier(MessageCongratulate(congratulated: message.congratulated))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                            self.message.congratulated = true
                        }
                    }
                   
            }
           
        }
                    .padding(10)
                    .padding(.horizontal,5)
                    .background{
                        if self.message.messageStyle != .congratulations{
                            BubbleShape(myMessage: !self.message.isIncoming)
                                .fill( message.isIncoming ? Color.init(uiColor: .systemGray4):  Color.blue)
                            
                        }else{
                            BubbleShape(myMessage: !self.message.isIncoming)
                                .fill(.pink)
                                .shadow(color:.red,radius:5)
                        }
                        
                    }
                    
                    .frame(maxWidth:sizeOFScreen.width / 2.2,alignment: message.isIncoming ? .leading: .trailing)
                    .onTapGesture{
                        self.message.onTap?()
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: message.isIncoming ? .leading: .trailing)
            
    }
}

#Preview {
    MessageBubble(message: .constant(MessageViewStruct(text: "Morse Code Tool", isIncoming: true,messageStyle:.congratulations,onTap: {
      
    })), sizeOFScreen: UIScreen.main.bounds.size)
}


struct MessageViewStruct:Identifiable,Equatable{
    var id: UUID = UUID()
    var text:String
    var isIncoming:Bool
    var messageStyle:MessageStyle = .message
    var onTap: (() -> Void)?
    var congratulated:Bool = false
    
    static func == (lhs: MessageViewStruct, rhs: MessageViewStruct) -> Bool {
  
           lhs.id == rhs.id &&
           lhs.text == rhs.text &&
           lhs.isIncoming == rhs.isIncoming &&
           lhs.messageStyle == rhs.messageStyle
       }
}
enum MessageStyle:Equatable{
    case message,tip,file(Image,String),link(Image,String),congratulations
}
 
struct MessageCongratulate:ViewModifier{
    let congratulated:Bool
    
    func body(content: Content) -> some View {
        if congratulated{
            content
        }else{
            content
                .particleEffect(systemImage: "heart.fill", font: .caption2, status: true, activeTint: .red, inactiveTint: .pink)
        }
    }
}
