
import Foundation
import SwiftUI
import SwiftData

struct MainView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var memos: [Memo]
    
    // Search Bar
    @State private var searchText = "" // search Text
    var filteredMemos: [Memo] {
            if searchText.isEmpty {
                // If search text is empty, return the original memos array
                return memos
            } else {
                // Filter memos based on whether searchText is contained in memo title or content
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
            
            /*
            VStack{
                CalenderView()
                
            }.padding()
                .background(Color(hex: 0xEAEAEB))
            */
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(filteredMemos.reversed()) { memo in // Use filteredMemos instead of memos
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

            .background(Color(hex: 0xEAEAEB))
            .navigationBarTitle("Talk Diary", displayMode: .inline)
            .navigationBarItems(trailing:
                                    HStack {
                NavigationLink(destination: ChattingView()
                    .toolbarRole(.editor)
                ) {
                    Image(systemName: "ellipsis.message")
                        .foregroundColor(.blue)
                }
                
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        HStack {
                            Spacer()
                            Menu(content: {
                                HStack{
                                    NavigationLink(destination: WritingView()
                                        .toolbarRole(.editor)
                                    ) {
                                        Text("Add new")
                                            .foregroundColor(.black)
                                        Image(systemName: "plus")
                                        Spacer()
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
                                    Spacer()
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
        .searchable(text: $searchText, prompt: "Search")
        
    }
    
    func deleteMemo(_ memo: Memo) {
        modelContext.delete(memo)
    }
}

// Memo Cell View
struct MemoCellView: View {
    
    let memo: Memo
    var onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack{
                Text(memo.title)
                    .font(.system(size: 20))
                    .padding(.leading)
                    .bold()
                    .foregroundColor(.green)
                    .lineLimit(1)
                Spacer()
                
                Text(memo.emoji)
                    .padding(.trailing)
                    .font(.system(size: 30))
            }
            HStack{
                Text(memo.content)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .padding(.leading)
                    .lineLimit(1)
                Spacer()
                
                Text("\(memo.time, formatter: WritingView.monthDayFormat)")
                    .padding(.trailing)
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
            }
        }
        .frame(maxWidth: .infinity, minHeight: 50) // 고정된 크기 적용
        .padding(10)
        .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
        .background(Color.white)
        .cornerRadius(20)
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
                }
        )
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

#Preview {
    MainView()
}


