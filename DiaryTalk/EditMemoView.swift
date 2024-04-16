//import SwiftUI
//import Foundation
//import SwiftData
//
//struct EditMemoView: View {
//    
//    @State private var editTitle: String
//    @State private var editContent: String
//    @State private var editEmoji: String
//    @State private var editTime: Date
//    
//    // var memo: Memo
//    
//    init(memo: Memo) {
//        self.editTitle = memo.title
//        self.editContent = memo.content
//        self.editEmoji = memo.emoji
//        self.editTime = memo.time
//        //      _title = State(initialValue: memo.title)
//        //      _content = State(initialValue: memo.content)
//    }
//    
//    
//    @Environment(\.modelContext) var modelContext
//    @Query var memos: [Memo]
//    
//    @State private var isPresentingEditMemoView = false
//    @Environment(\.presentationMode) private var presentationMode
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                TextField("Title", text: $editTitle)
//                    .padding()
//                    .padding(.leading, 5)
//                    .bold()
//                    .foregroundColor(Color(hex: 0xE2B100))
//                    .cornerRadius(10)
//                
//                TextEditor(text: $editContent)
//                    .scrollContentBackground(.hidden)
//                    .background(.clear)
//                    .padding(.leading)
//                    .cornerRadius(10)
//                    .lineSpacing(10)
//                
//                Spacer()
//            }
//            .padding()
//        }.navigationBarBackButtonHidden()
//            .navigationBarItems(
//                leading: Button("Cancel") {
//                    isPresentingEditMemoView = true
//                },
//                trailing: Button("SAVE") {
//                    //updateMemo()
//                    self.presentationMode.wrappedValue.dismiss()
//                })
////            .onAppear(){
////                self.editTitle = memo.title
////                self.editContent = memo.content
////                self.editEmoji = memo.emoji
////                self.editTime = memo.time
////            }
//    }
//    /*
//    func updateMemo(_ memo: Memo) {
//        memo.title = editTitle
//        memo.content = editContent
//        memo.emoji = editEmoji
//        memo.time = editTime
//        try? modelContext.save()
//    }
//    */
////    func updateMemo() {
////        var memo = Memo(title: editTitle, content: editContent, emoji: editEmoji, time: editTime)
////        memo.title = editTitle
////        memo.content = editContent
////        try? modelContext.save()
////    }
//    
//}
