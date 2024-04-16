
import Foundation
import SwiftUI
struct MemoDetailView: View {
    
//    @State var title: String
//    @State var content: String
//    @State var emoji: String
//    @State var time: Date
    
    @State private var isEditing = false // Editing mode 여부
    
    //  var today = Date()
    @State private var showModal = false // Mood 모달
    @State private var isPresentingEditMemoView = false
    
    // let memo: Memo
    @Bindable var memo: Memo
    
    /*
    init(memo: Memo) { // 저장된 메모를 초기화하면서 받음
        self.title = memo.title
        self.content = memo.content
        self.emoji = memo.emoji
        self.time = memo.time
    }
    */
    
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.2)
                    .ignoresSafeArea()
                
                VStack {
                    HStack{
                        Text("\(memo.time, formatter: WritingView.timeFormat)")
                            .environment(\.locale, Locale(identifier: "ko_KR"))
                            .foregroundColor(.gray.opacity(0.7))
                        Text(memo.emoji)
                    }.padding()
                   
                    VStack{
                        HStack{
                            if isEditing {
                                TextField("Title", text: $memo.title)
                                    // .foregroundColor(Color(hex: 0xE2B100))
                                    .bold()
                                    .padding(.leading,5)
                            } else {
                                Text(memo.title)
                                    // .foregroundColor(Color(hex: 0xE2B100))
                                    .bold()
                                    .padding(.leading,5)
                            }
                            
                            Spacer()
                        }.padding()
                        HStack{
                            if isEditing {
                                TextEditor(text: $memo.content)
                                    .padding(.leading,5 )
                                    .lineSpacing(10)
                                    .scrollContentBackground(.hidden)
                                    .background(.clear)
                            } else {
                                Text(memo.content)
                                    .padding(.leading,5 )
                                    .lineSpacing(10)
                            }
                            Spacer()
                        }.padding()
                    }.padding()
                    Spacer()
                }
            }
        }//.navigationBarItems(trailing:
//                                Button(action: {
//                                    // Present the EditMemoView modally
//                                    isPresentingEditMemoView = true
//                                }) {
//                                    Image(systemName: "square.and.pencil")
//                                }
//                                .sheet(isPresented: $isPresentingEditMemoView) {
//                                    NavigationView {
//                                        //EditMemoView(memo: Memo(title: title, content: content, emoji: emoji, time: time))
//                                        //    .toolbarRole(.editor)
//                                            
//                                    }
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarTrailing) {
                                        Button(action: {
                                            isEditing.toggle()
                                        }) {
                                            Text(isEditing ? "Done" : "Edit")
                                        }
                                    }
                                }
        .onAppear {
            if let mode = editMode {
                isEditing = mode.wrappedValue == .active
            }
        }
    }
}

/*
 #Preview {
 MemoDetailView()
 }
 */
