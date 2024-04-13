import SwiftUI
import Foundation
import Combine
import SwiftData

struct Message: Hashable {
    var id = UUID()
    var content: String
    var isCurrentUser: Bool
}

struct ChattingView: View {
    
    @Query var chats: [Chat]
    @Environment(\.modelContext) var modelContext
    
    @State private var chatting: [Message] = []
    @State private var newMessage: String = ""
    
    var body: some View {
        
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(chats, id:\.self) { chat in
                            MessageCell(chat: chat)
                                .id(chat)
                            
                        }
                        /*
                        ForEach(chatting, id: \.self) { chat in
                            MessageView(currentMessage: chat)
                                .id(chat)
                        }
                         */
                    }
                    .onReceive(Just(chats)) { _ in
                        withAnimation {
                            proxy.scrollTo(chats.last, anchor: .bottom)
                        }
                        
                    }.onAppear {
                        withAnimation {
                            proxy.scrollTo(chats.last, anchor: .bottom)
                        }
                    }
                }
                
                
                // send new message
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "photo")
                            .foregroundColor(.black)
                            .frame(width: 15, height: 15)
                    }) .padding(15)
                        .background(
                            Circle()
                                .foregroundColor(.white)
                                .shadow(color: .gray, radius: 1, x: 1, y: 1)
                        )
                        .overlay(
                            Circle()
                                .stroke(lineWidth: 1)
                                .foregroundColor(.white)
                        )
                    
                    TextField("", text: $newMessage)
                        .textFieldStyle(.roundedBorder)
                    
                    
                    Button{action: do {
                        saveMessage()
                        print("Chatting 배열 : \(chatting)")
                    }
                    }label: {
                        Image(systemName: "paperplane")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.orange)
                            .frame(width: 20, height: 20)
                    }.padding(15)
                        .background(
                            Circle()
                                .foregroundColor(.white)
                                .shadow(color: .gray, radius: 1, x: 1, y: 1)
                        )
                }
                .padding()
            }.navigationTitle("Talk me🗣️")
        }
    }
    
    func saveMessage() {
        if !newMessage.isEmpty {
            let message = Chat(chatMessage: newMessage)
            modelContext.insert(message)
            
            print("Saved message: \(newMessage)")
            
            chatting.append(Message(content: newMessage, isCurrentUser: true))
            newMessage = ""
        }
    }
}

struct MessageCell: View {
    
    let chat: Chat
    
    //var contentMessage: String
    //var isCurrentUser: Bool
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                
                Text(chat.chatMessage)
                    .padding(10)
                    .foregroundColor(Color.white)
                    .background(Color.orange)
                    .cornerRadius(10)
            }.padding(5)
                .padding(.trailing, 10)
        }
    }
}
#Preview {
    ChattingView()
}
