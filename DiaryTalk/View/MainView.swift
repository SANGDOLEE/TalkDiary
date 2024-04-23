
import Foundation
import SwiftUI
import SwiftData

struct MainView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var memos: [Memo]
    
    @State private var multiSelection = Set<UUID>()
    
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
    
    let columns = [ GridItem(.flexible()) ]
    
    var body: some View {
        NavigationStack {
            VStack{
                ScrollView{
                    LazyVStack {
                        ForEach(filteredMemos.reversed(), id: \.id) { memo in
                            NavigationLink(destination: MemoDetailView(memo: memo)) { // cell을 눌렀을 때 DetailView로 이동
                                MemoCellView(memo: memo, onDelete: {
                                    deleteMemo(memo)
                                })
                                .swipeToDelete(at: filteredMemos.firstIndex(of: memo) ?? 0) {
                                    deleteMemo(memo)
                                }
                            }
                        }
                    }
                }.padding(.horizontal)
                    .background(Color(hex: 0xEAEAEB))
                    .navigationBarTitle("Talkary")
                    .navigationBarItems(trailing:
                                            HStack {
                        NavigationLink(destination: ChattingView()
                            .toolbarRole(.editor)
                        ) {
                            Image(systemName: "message.fill")
                        }
                        .toolbar {
                            ToolbarItem(placement: .primaryAction) {
                                HStack {
                                    Spacer()
                                    Menu(content: {
                                        
                                        HStack{
                                            NavigationLink(destination: CalendarView()
                                                .toolbarRole(.editor) // NavigationBackbutton label 끄기
                                            ) {
                                                Text("Calendar")
                                                    .foregroundColor(.black)
                                                Image(systemName: "calendar")
                                            }
                                        }
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
                HStack {
                    NavigationLink(destination: WritingView()) {
                        Text("+ New Diary")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .bold()
                            .padding(.vertical, 15)
                            .padding(.horizontal, 120)
                            .background(Color.blue)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                    }
                }.padding(.bottom, 10)
                
            } // VSTACK
            .background(Color(hex: 0xEAEAEC))
        }
        .searchable(text: $searchText, prompt: "") // Search Bar
    }
    
    // 삭제
    func deleteMemo(_ memo: Memo) {
        modelContext.delete(memo)
    }
    
}

struct MemoCellView: View {
    
    let memo: Memo
    var onDelete: () -> Void
    
    var body: some View {
        HStack() {
            HStack{
                Circle()
                    .foregroundColor(.blue.opacity(0.5))
                    .frame(width: 42, height: 42)
                    .overlay(
                        Text(memo.emoji)
                            .font(.system(size: 39))
                            .foregroundColor(.white)
                    )
            }
            VStack{
                HStack{
                    Text(memo.title) // 12자까지만 표기
                        .font(.system(size: 16))
                        .bold()
                        .foregroundColor(.black)
                        .lineLimit(1)
                    
                    Spacer()
                }
                HStack{
                    Text(memo.content)
                        .font(.system(size: 14))
                        .foregroundColor(.gray.opacity(0.7))
                        .lineLimit(1)
                    Spacer()
                }
            }
            Spacer()
            Text("\(memo.time, formatter: WritingView.monthDayFormat)")
                .foregroundColor(.gray.opacity(0.7))
                .font(.system(size: 14))
            Image(systemName: "chevron.right")
                .foregroundColor(.gray.opacity(0.7))
                .font(.system(size:14))
            
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 35) // 고정된 크기 적용
        .background(Color.white)
        .cornerRadius(10)
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
extension View {
    func swipeToDelete(at index: Int, action: @escaping () -> Void) -> some View {
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

#Preview {
    MainView()
}
