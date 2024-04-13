import SwiftUI
import Foundation
import Combine
import SwiftData

struct Message: Hashable {
    var id = UUID()
    var content: String
    var isCurrentUser: Bool
}


struct DataSource {
    
    static let messages = [
        
        Message(content: "Hi there!", isCurrentUser: true),
        
    ]
}

struct ChattingView: View {
    
    @Query var chats: [Chat]
    
    @Environment(\.modelContext) var modelContext
    
    @State var messages = DataSource.messages
    @State private var newMessage: String = ""
    
    var body: some View {
        
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(messages, id: \.self) { message in
                            MessageView(currentMessage: message)
                                .id(message)
                        }
                    }
                    .onReceive(Just(messages)) { _ in
                        withAnimation {
                            proxy.scrollTo(messages.last, anchor: .bottom)
                        }
                        
                    }.onAppear {
                        withAnimation {
                            proxy.scrollTo(messages.last, anchor: .bottom)
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
                    
                    TextField("Send a message", text: $newMessage)
                        .textFieldStyle(.roundedBorder)
                    
                    
                    Button(action: sendMessage)   {
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
    
    func sendMessage() {
        if !newMessage.isEmpty{
            messages.append(Message(content: newMessage, isCurrentUser: true))
            newMessage = ""
        }
    }
    
    func addMessage() {
        let message = Chat(chatMessage: newMessage)
        modelContext.insert(message)
    }
}


struct MessageCell: View {
    
    //let chat: Chat
    
    var contentMessage: String
    var isCurrentUser: Bool
    
    var body: some View {
        Text(contentMessage)
            .padding(10)
            .foregroundColor(Color.white)
            .background(Color.orange)
            .cornerRadius(10)
    }
}

#Preview {
    ChattingView()
}
