//import SwiftUI
//
//struct WriteView: View {
//    
//    @State private var typing: String = ""
//    @State private var messages: [Message] = []
//    
//    var body: some View {
//        VStack {
//            Image("sf_ggb")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 360)
//                .cornerRadius(16)
//                .padding(.top)
//            
//            // 고양이 질문 부분
//            HStack(spacing: 16) {
//                Image("cat")
//                SpeechBubble(text: "\"오늘 있었던 일을 간단히 설명해줘\"")
//            }
//            .padding(.top) // 화면 상단에 여백 추가
//            .padding(.horizontal) // 좌우 여백 추가
//            
//            ScrollView {
//                VStack(alignment: .trailing, spacing: 16) {
//                    ForEach(messages, id: \.self) { message in
//                        HStack {
//                            if message.isFromCurrentUser {
//                                Spacer()
//                                Text(message.text)
//                                    .padding(10)
//                                    .background(Color.blue)
//                                    .clipShape(ChatBubble(isFromCurrentUser: true))
//                                    .padding(.horizontal, 10)
//                            } else {
//                                Text(message.text)
//                                    .padding(10)
//                                    .background(Color.gray.opacity(0.7))
//                                    .clipShape(ChatBubble(isFromCurrentUser: false))
//                                    .padding(.horizontal, 10)
//                                Spacer()
//                            }
//                        }
//                        .foregroundColor(.white)
//                    }
//                }
//                .padding(.top)
//            }
//            .padding(10)
//            
//            
//            HStack {
//                TextField("너의 이야기를 들려줘", text: $typing)
//                    .frame(height: 30)
//                    .textFieldStyle(.roundedBorder)
//                    .onAppear {
//                        UITextField.appearance().clearButtonMode = .whileEditing
//                    }
//                
//                Spacer() // 전송 버튼을 화면 오른쪽으로 이동시킬 공간
//                
//                Button(action: {
//                    sendMessage()
//                }) {
//                    Text("전송")
//                }
//            }
//            .padding()
//            
//        }
//        .onReceive(messages.publisher.first()) { _ in
//            scrollToBottom()
//        }
//        
//    }
//    
//    // 전송 버튼을 누를 때 호출되는 함수
//    func sendMessage() {
//        if !typing.isEmpty {
//            // 사용자의 메시지를 배열에 추가
//            messages.append(Message(text: typing, isFromCurrentUser: true))
//            typing = "" // 입력 필드 초기화
//            
//        
//        }
//    }
//    
//    
//    // ScrollView를 가장 아래로 스크롤하는 함수
//    private func scrollToBottom() {
//        DispatchQueue.main.async {
//            guard !messages.isEmpty else { return }
//            withAnimation {
//                // 스크롤뷰의 사이즈를 가져옴
//                let size = messages.count - 1
//                // 스크롤뷰로 이동
//                // AnchorPreferenceKey를 사용해서 마지막 엘리먼트로 이동
//            }
//        }
//    }
//}
//
//struct SpeechBubble: View {
//    var text: String
//    
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 10)
//                .fill(Color.gray.opacity(0.7)) // 연한 회색으로 설정
//                .frame(height: 130) // 높이를 130으로 설정
//            Text(text)
//                .foregroundColor(.white)
//                .padding()
//        }
//    }
//}
//
//
//struct WriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        WriteView()
//    }
//}
//
//
