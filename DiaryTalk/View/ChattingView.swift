import SwiftUI
import Foundation
import Combine
import SwiftData

struct Message: Hashable {
    var id = UUID()
    var content: String
    var isCurrentUser: Bool
    var sendTime: Date
    var day: Date
}

struct ChattingView: View {
    
    @Query var chats: [Chat]
    @Environment(\.modelContext) var modelContext
    
    @State private var chatting: [Message] = []
    @State private var newMessage: String = ""
    
    @State var showImagePicker = false
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    
    /// 채팅날짜 & 시간
    static let timeFormat: DateFormatter = {
        var formatter_time = DateFormatter()
        formatter_time.dateFormat = "aa HH:mm"
        return formatter_time
    }()
    var time = Date()
    
//    @State private var previousDate: Date?
    
    var body: some View {
        
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(chats, id:\.self) { chat in
                            // chatDayText(chat: chat) // 나중에 수정바람 ✅✅✅✅
                            
                            MessageCell(chat: chat)
                                .id(chat)
                            
                        }
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
                
                /// 사진 - 채팅 입력 - 전송
                HStack {
                    Button(action: {
                        showImagePicker.toggle()
                    }, label: {
                        Image(systemName: "photo")
                            .foregroundColor(.blue)
                            .frame(width: 15, height: 15)
                    }).sheet(isPresented: $showImagePicker, onDismiss: {
                        loadImage()
                    }) {
                        ImagePicker(image: $selectedUIImage)
                    } .padding(15)
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
                            .foregroundColor(newMessage.isEmpty ? .gray : .blue)
                        
                            .frame(width: 20, height: 20)
                    }.disabled(newMessage.isEmpty) // 텍스트 비어있으면 비활성화
                        .padding(15)
                        .background(
                            Circle()
                                .foregroundColor(.white)
                                .shadow(color: .gray, radius: 1, x: 1, y: 1)
                        )
                }
                .padding(.horizontal)
                .padding(.bottom)
            }.navigationTitle("Talk me🗣️")
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
        }
    }
    
    func saveMessage() {
        if !newMessage.isEmpty {
            let message = Chat(chatMessage: newMessage, chatTime: time, chatDay: time)
            modelContext.insert(message)
            
            print("Saved message: \(newMessage)")
            
            chatting.append(Message(content: newMessage, isCurrentUser: true, sendTime: time, day: time))
            newMessage = ""
            
            
        }
    }
    
    func loadImage() {
        guard let selectedImage = selectedUIImage else { return }
        image = Image(uiImage: selectedImage)
       
    }
}


struct MessageCell: View {
    
    let chat: Chat
    
    var body: some View {
        VStack{
           /*
                Text("\(chat.chatDay, formatter: WritingView.dateFormat)")
                    .environment(\.locale, Locale(identifier: "ko_KR"))
                    .padding(.top, 20)
                    .font(.system(size: 14))
                    .foregroundColor(.gray.opacity(0.7))
            */
            HStack{
                Spacer()
                Text("\(chat.chatTime, formatter: ChattingView.timeFormat)")
                    .environment(\.locale, Locale(identifier: "ko_KR"))
                    .padding(.top, 20)
                    .font(.system(size: 10))
                    .foregroundColor(.gray.opacity(0.7))
                
                Text(chat.chatMessage)
                    .padding(12)
                    .font(.system(size: 11))
                    .foregroundColor(Color.white)
                    .background(.blue)
                    //.background(Color(hex: 0xE2B100))
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
            }.padding(5)
                .padding(.trailing, 10)
        }
    }
    
    
    // 날짜가 바꼈을때만 한번만 나오게 !
    /*
    private func shouldDisplayDay() -> Bool {
        guard let previousDay = UserDefaults.standard.value(forKey: "previousDay") as? Date else {
            UserDefaults.standard.set(chat.chatDay, forKey: "previousDay")
            return true
        }
        
        if !Calendar.current.isDate(chat.chatDay, inSameDayAs: previousDay) {
            UserDefaults.standard.set(chat.chatDay, forKey: "previousDay")
            return true
        }
        
        return false
    }
     */
     
}

struct chatDayText: View {
    
    let chat: Chat
    
    var body: some View {
        Text("\(chat.chatTime, formatter: WritingView.dateFormat)")
            .environment(\.locale, Locale(identifier: "ko_KR"))
            .padding(.top, 20)
            .font(.system(size: 12))
            .foregroundColor(.gray.opacity(0.7))
    }
}

#Preview {
    ChattingView()
}
