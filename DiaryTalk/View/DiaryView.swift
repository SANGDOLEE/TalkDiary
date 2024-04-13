//
//import Foundation
//import SwiftUI
//
//struct Message: Identifiable, Hashable {
//    var id = UUID()
//    var content: String
//    var isCurrentUser: Bool
//}
//
//struct DiaryView: View {
//    
//    // Date Formmater
//    static let dateFormat: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy년 M월 d일 E요일"
//        return formatter
//    }()
//    
//    @State private var showModal = false // Mood 모달
//    
//    var today = Date()
//    
//    @State private var typingMessage: String = "" // 사용자가 입력한 텍스트
//    @State private var messages: [Message] = [] // 입력한 텍스트가 저장될 배열
//    
//    let temps = ["Apple Developer Academy"] // 임시값임 . 나중에 지우기
//    
//    var body: some View {
//        
//        NavigationView {
//            VStack{
//                Text("\(today, formatter: DiaryView.dateFormat)")
//                    .environment(\.locale, Locale(identifier: "ko_KR"))
//                    .foregroundColor(Color(hex: 0x555555))
//                Spacer()
//                
//                ScrollView() {
//                    VStack(alignment: .trailing, spacing: 16){
//                        ForEach(messages, id: \.self){ message in
//                            HStack{
//                                Spacer()
//                                ChatMessageView(typeMessage: typingMessage, direction: .right )
//                                    .padding(.top, 10)
//                                    .padding(.trailing, 30)
//                            }
//                        }
//                        ForEach(messages, id: \.self) { message in
//                            Text(message.content)
//                                .padding(10)
//                                .background(Color.blue)
//                            .padding(.horizontal, 10)}
//                    }
//                    .frame(maxWidth: .infinity)
//                    
//                }.padding(.vertical)
//                
//                Spacer()
//                
//                HStack{
//                    Button(action: {
//                        
//                    }, label: {
//                        Image(systemName: "photo")
//                            .foregroundColor(.black)
//                            .frame(width: 15, height: 15)
//                    }) .padding(15)
//                        .background(
//                            Circle()
//                                .foregroundColor(.white)
//                                .shadow(color: .gray, radius: 1, x: 1, y: 1)
//                        )
//                        .overlay(
//                            Circle()
//                                .stroke(lineWidth: 1)
//                                .foregroundColor(.white)
//                        )
//                   
//                    TextWritingView(text: typingMessage)
//                        .background(Color(hex: 0xEAEAEB))
//                        .cornerRadius(20)
//                    
//                    Spacer()
//                    Button(action: {
//                        
//                        print(messages)
//                        
//                        if !typingMessage.isEmpty {
//                            sendMessage()
//                        }
//                        
//                        typingMessage = ""
//                        
//                    }, label: {
//                        Image(systemName: "paperplane")
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .foregroundColor(.green)
//                            .frame(width: 20, height: 20)
//                        
//                    })
//                    .padding(15)
//                    .background(
//                        Circle()
//                            .foregroundColor(.white)
//                            .shadow(color: .gray, radius: 1, x: 1, y: 1)
//                    )
//                    
//                    .overlay(
//                        Circle()
//                            .stroke(lineWidth: 1)
//                            .foregroundColor(.white)
//                    )
//                }.padding()
//            }
//        }
//        .navigationTitle("Talk Me")
//    }
//    
//    func sendMessage() {
//        if !typingMessage.isEmpty {
//            messages.append(Message(content: typingMessage, isCurrentUser: true))
//            typingMessage = "" // Clear typing field
//        }
//    }
//    
//}
//
//private struct TextWritingView: View {
//    
//    @State private var height: CGFloat = 30
//    @State var text: String = ""
//    
//    private var registerButtonDisabled: Bool {
//        text.isEmpty
//    }
//    private var registerButtonTextColor: Color {
//        text.isEmpty ? .red : .green
//    }
//    
//    var body: some View {
//        HStack(alignment: .bottom, spacing: 10) {
//            
//            // 메세지 입력창
//            CustomTextView(
//                text: $text,
//                height: $height,
//                maxHeight: 200,
//                textFont: .boldSystemFont(ofSize: 14),
//                cornerRadius: 15,
//                borderWidth: 1,
//                borderColor: CGColor.init(red: 255, green: 255, blue: 255, alpha: 1),
//                placeholder: "댓글을 입력해 주세요"
//            )
//            .frame(minHeight: height, maxHeight: .infinity)
//        }
//        .padding(.all, 10)
//        .frame(height: 50)
//        .frame(minHeight: height)
//    }
//}
//
//
//enum ChatMessageDirection {
//    case left
//    case right
//}
//
//struct ChatMessageView: View {
//    
//    let typeMessage: String
//    let direction: ChatMessageDirection
//    
//    var body: some View{
//        Text(typeMessage)
//            .padding()
//            .background(.blue)
//            .foregroundColor(.white)
//            .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
//            .listRowSeparator(.hidden)
//            .overlay(alignment: direction == .left ? .bottomLeading : .bottomTrailing){
//                Image(systemName: "arrowtriangle.down.fill")
//                    .font(.title)
//                    .rotationEffect(.degrees(direction == .left ? 45: -45))
//                    .offset(x: direction == .left ? -10: 10, y: 10)
//                    .foregroundColor(.blue)
//            }
//    }
//}
//
//#Preview {
//    DiaryView()
//}
