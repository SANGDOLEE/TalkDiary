//import SwiftUI
//import Combine
//import MarkdownUI
//
//struct TodayLogView: View {
//    @State private var post: String = ""
//    @State private var markdownPreview: String = ""
//    private var cancellables = Set<AnyCancellable>()
//    
//    var body: some View {
//        VStack {
//            TextEditor(text: $post)
//                .padding()
//                .onReceive(Just(post)) { newValue in
//                    // 입력된 텍스트를 Markdown으로 변환하여 미리보기
//                    markdownPreview = newValue
//                }
//            
//            Markdown(markdownPreview)
//                .padding()
//                .border(Color.gray)
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    TodayLogView()
//}
