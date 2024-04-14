import SwiftUI
import Foundation
import Combine
import SwiftData

struct Message: Hashable {
    var id = UUID()
    var content: String
    var isCurrentUser: Bool
    var sendTime: Date
}

struct ChattingView: View {
    
    @Query var chats: [Chat]
    @Environment(\.modelContext) var modelContext
    
    @State private var chatting: [Message] = []
    @State private var newMessage: String = ""
    
    
    static let timeFormat: DateFormatter = {
        var formatter_time = DateFormatter()
        formatter_time.dateFormat = "aa HH:mm"
        return formatter_time
    }()
    
    var time = Date()
    
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
                            .foregroundColor(.green)
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
                            .foregroundColor(.green)
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
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
        }
    }
    
    func saveMessage() {
        if !newMessage.isEmpty {
            let message = Chat(chatMessage: newMessage, chatTime: time)
            modelContext.insert(message)
            
            print("Saved message: \(newMessage)")
            
            chatting.append(Message(content: newMessage, isCurrentUser: true, sendTime: time))
            newMessage = ""
        }
    }
       // 현재 시간을 가져오는 함수
       func getCurrentTime() -> Date {
           return Date()
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
                Text("\(chat.chatTime, formatter: ChattingView.timeFormat)")
                    .padding(.top, 20)
                    .font(.system(size: 10))
                    .foregroundColor(.gray.opacity(0.7))
                
                Text(chat.chatMessage)
                    .padding(10)
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .cornerRadius(10)
            }.padding(5)
                .padding(.trailing, 10)
        }
    }
}
#Preview {
    ChattingView()
}
