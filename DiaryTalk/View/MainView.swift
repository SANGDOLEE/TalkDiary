
import Foundation
import SwiftUI
import SwiftData

struct MainView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var memos: [Memo]
    
    @State private var multiSelection = Set<UUID>()
    
    // var memo: Memo
    // Search Bar
    @State private var searchText = "" // search Text
    var filteredMemos: [Memo] {
        if searchText.isEmpty {
            return memos
        } else {
            return memos.filter { memo in
                memo.title.localizedCaseInsensitiveContains(searchText) ||
                memo.content.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            List(selection: $multiSelection) {
                ForEach(filteredMemos.reversed(), id: \.id) { memo in
                    NavigationLink(destination: MemoDetailView(memo: memo)) { // cell을 눌렀을 때 DetailView로 이동
                        
                        MemoCellView(memo: memo, onDelete: { // ㅣist에 memo가 cell로 저장됨
                            deleteMemo(memo)
                            
                        })
                        
                    }.toolbarRole(.editor) // NavigationBackButton LabelHidden인데 적용안됨
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        deleteMemo(filteredMemos[index])
                    }
                }
            }.listRowSeparatorTint(.blue)
//                .toolbar { EditButton() } ✅✅✅
            //.padding(.horizontal)
            //.padding(.bottom)
            
            /*
             ScrollView {
             LazyVGrid(columns: columns, spacing: 10) {
             ForEach(filteredMemos.reversed()) { memo in
             MemoCellView(memo: memo, onDelete: {
             deleteMemo(memo)
             })
             .swipeToDelete {
             deleteMemo(memo)
             }
             }
             }
             .padding(.horizontal)
             .padding(.bottom)
             }
             */
            
            .background(Color(hex: 0xEAEAEB))
            //.navigationBarTitle("Talk Diary")
            .navigationBarTitle("Talk Diary", displayMode: .inline)
            .navigationBarItems(trailing:
                                    HStack {
                NavigationLink(destination: ChattingView()
                    .toolbarRole(.editor)
                ) {
                    Image(systemName: "ellipsis.message")
                    // .foregroundColor(.green)
                }
                
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        HStack {
                            Spacer()
                            Menu(content: {
                                HStack{
                                    NavigationLink(destination: WritingView()
                                        .toolbarRole(.editor) // NavigationBackbutton label 끄기
                                    ) {
                                        Text("Add new")
                                            .foregroundColor(.black)
                                        Image(systemName: "plus")
                                    }
                                }
                                
                                Button(action: {
                                   
                                }, label: {
                                    Text("Select")
                                    Image(systemName: "checkmark")
                                    
                                })
                                
                                NavigationLink(destination: SettingView()) {
                                    
                                    Text("Setting")
                                        .foregroundColor(.black)
                                    Image(systemName: "gear")
                                    
                                }
                                
                            }, label: {
                                Label("more", systemImage: "ellipsis")
                                    .foregroundColor(.yellow)
                            })
                            
                            Spacer()
                        }
                    }
                }
            })
        }
        .searchable(text: $searchText, prompt: "Search") // Search Bar
    }
    
    func deleteMemo(_ memo: Memo) {
        modelContext.delete(memo)
    }
}

// MemoCell View
struct MemoCellView: View {
    
    let memo: Memo
    var onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack{
                Text(memo.title.prefix(12)) // 12자까지만 표기
                    .font(.system(size: 20))
                
                    .bold()
                    .foregroundColor(.black)
                    .lineLimit(1)
                Spacer()
                
                Text(memo.emoji)
                
                    .font(.system(size: 20))
            }
            HStack{
                Text(memo.content)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                
                    .lineLimit(1)
                Spacer()
                
                Text("\(memo.time, formatter: WritingView.monthDayFormat)")
                
                    .foregroundColor(.gray.opacity(0.7))
                    .font(.system(size: 14))
            }
        }
        .frame(maxWidth: .infinity, minHeight: 35) // 고정된 크기 적용
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
        .padding(5)
        .contextMenu {
            Button(action: {
                onDelete()
            }) {
                Text("Delete")
                Image(systemName: "trash")
            }
        }
    }
}

// 스와이프 삭제
extension View {
    func swipeToDelete(action: @escaping () -> Void) -> some View {
        return self.gesture(
            DragGesture()
                .onEnded { gesture in
                    if gesture.translation.width < -100 {
                        action()
                    }
                })
    }
}

// Hex Color
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}

/*
 #Preview {
 MainView()
 }
 */
