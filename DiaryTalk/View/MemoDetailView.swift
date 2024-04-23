
import Foundation
import SwiftUI

struct MemoDetailView: View {
    
    @State private var isEditing = false // Editing mode 여부
    
    @State private var showModal = false // Mood 모달
    @State private var isPresentingEditMemoView = false
    
    @Bindable var memo: Memo
    
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
                                    .bold()
                                    .padding(.leading,5)
                            } else {
                                Text(memo.title)
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
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isEditing.toggle()
                }) {
                    if isEditing {
                        Image(systemName: "checkmark.circle.fill")
                    } else {
                        Image(systemName: "square.and.pencil")
                    }
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
