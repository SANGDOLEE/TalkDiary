//import SwiftUI
//import Foundation
//
//struct MessageView : View {
//    
//    var currentMessage: Message
//    
//    let chat: Chat
//    
//    var body: some View {
//        HStack(alignment: .bottom, spacing: 10) {
//            
//            if !currentMessage.isCurrentUser {
//                Image(systemName: "person.circle.fill")
//                    .resizable()
//                    .frame(width: 40, height: 40, alignment: .center)
//                    .cornerRadius(20)
//            } else {
//                Spacer()
//            }
//            MessageCell(chat: Chat(chatMessage: currentMessage.content, chatTime: currentMessage.sendTime,chatDay: currentMessage.day)//,
//                        /*contentMessage: currentMessage.content,
//                        isCurrentUser: currentMessage.isCurrentUser*/)
//        }
//        .frame(maxWidth: .infinity, alignment: .leading)
//        .padding()
//    }
//}
