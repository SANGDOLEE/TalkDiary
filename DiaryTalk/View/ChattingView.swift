import SwiftUI
import Foundation
import Combine
import SwiftData
import PhotosUI

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
    @Query var Photo: [Photo]
    
    @State private var chatting: [Message] = []
    @State private var newMessage: String = ""
    
    // 앨범(이미지)
    @State private var images: [UIImage] = []
    @State private var photosPickerItems: [PhotosPickerItem] = []
    
    /// 채팅날짜 & 시간
    static let timeFormat: DateFormatter = {
        var formatter_time = DateFormatter()
        formatter_time.dateFormat = "aa HH:mm"
        return formatter_time
    }()
    var time = Date()
    
    // 각 날짜별로 최근의 chatTime을 저장할 딕셔너리
    //@State private var latestChatTimeByDay: [Date: Date] = [:]
    //@State private var previousDate: Date?
    
    var body: some View {
        
        VStack {
            ScrollViewReader { proxy in
                ScrollView() {
                    LazyVStack {
                        VStack{
                            Text("\(time, formatter: WritingView.dateFormat)")
                                .environment(\.locale, Locale(identifier: "ko_KR"))
                                .padding(.top, 20)
                                .font(.system(size: 14))
                                .foregroundColor(.gray.opacity(0.7))
                        }
                        ForEach(chats, id:\.self) { chat in
                            MessageCell(chat: chat)
                                .id(chat)
                        }
                        HStack{
                            Spacer()
                            VStack{
                                Spacer()
                                ForEach(0..<images.count, id:\.self) { i in
                                    Image(uiImage: images[i])
                                        .resizable()
                                        .cornerRadius(10)
                                        .frame(width: 140, height: 140)
                                        .padding(.horizontal)
                                        .padding(.top, 5)
                                }
                            }
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
                    PhotosPicker("+", selection: $photosPickerItems, maxSelectionCount: 5, selectionBehavior: .ordered)
                        .foregroundColor(.gray)
                        .padding(20)
                        .background(
                            Circle()
                                .foregroundColor(.white)
                                .shadow(color: .gray, radius: 1, x: 1, y: 1)
                        )
                        .overlay(
                            Circle()
                                .stroke(lineWidth: 1)
                                .foregroundColor(.gray.opacity(0.1))
                        )
                        .onChange(of: photosPickerItems) { _ , _ in
                            Task {
                                for item in photosPickerItems {
                                    if let data = try? await item.loadTransferable(type: Data.self) {
                                        if let image = UIImage(data: data) {
                                            images.append(image)
                                            // let img = DiaryTalk.Photo(imgData: data, imgTime: time)
                                           // modelContext.insert(img)
                                        }
                                    }
                                }
                                photosPickerItems.removeAll()
                            }
                        }
                    
                    
                    TextField("", text: $newMessage)
                        .textFieldStyle(.roundedBorder)
                    
                    
                    Button{action: do {
                        saveMessage()
                        print("Chatting 배열 : \(chatting)")
                    }}label: {
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
            } .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(systemName: "bonjour")
                }
            }
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
    
    func saveImage() async {
        for item in photosPickerItems {
            if let data = try? await item.loadTransferable(type: Data.self) {
                let photo = DiaryTalk.Photo(imgData: data, imgTime: time)
                modelContext.insert(photo)
            }
        }
        photosPickerItems.removeAll()
    }
    
    
}

struct PhotoCell: View {
    let image: Image?
    
    var body: some View {
        HStack {
            if let image = image {
                image
                    .resizable()
                    .clipShape(Rectangle())
                    .frame(width: 44, height: 44)
            }
        }.foregroundColor(Color.white)
            .background(.blue)
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
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
            }.padding(5)
                .padding(.trailing, 10)
        }
    }
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

/*
 #Preview {
 ChattingView()
 }
 */

/*
 
 //                        Image(systemName: "photo")
 //                                .resizable()
 //                                .aspectRatio(contentMode: .fit)
 //                                .foregroundColor(.blue)
 //                                .frame(width: 25, height: 25)
 //                                .clipShape(Circle())
 //                                .padding()
 //                                //.background(.red)
 
 */
