
import Foundation
import SwiftUI

struct WritingView: View {
    
    @State private var memoTitle = "" // title
    @State private var memoContent = "" // contenxt
    @State private var selectedEmoji = "" // 선택한 emoji 저장
    
    @Environment(\.modelContext) var modelContext
    
    // Edit <-> Done
    @State private var doneStatus = true
    
    // Mood 선택
    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일 E요일"
        return formatter
    }()
    
    static let monthDayFormat: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "M월 d일"
           return formatter
       }()
    
    var today = Date()
    @State private var showModal = false // Mood 모달
    
    // KeyBoard Tool bar
    @State private var text = ""
    @State private var isBold = false
    
    var body: some View {
        NavigationStack{
            
            ZStack{
                Color.gray.opacity(0.2)
                    .ignoresSafeArea()
                
                VStack {
                    VStack{
                        Button(action: {
                            self.showModal = true
                        }, label: {
                            if selectedEmoji.isEmpty { // 선택된 Emoji가 없으면 plus 아이콘 표시
                                Image(systemName: "plus")
                                    .foregroundColor(.green)
                            } else { // 선택된 Emoji가 있으면 해당 Emoji 표시
                                Text(selectedEmoji)
                                    .font(.system(size: 30))
                                    .sheet(isPresented: self.$showModal) {
                                        SelectMoodView(selectedEmoji: self.$selectedEmoji)
                                    }
                            }
                        })
                        .sheet(isPresented: self.$showModal) {
                            SelectMoodView(selectedEmoji: self.$selectedEmoji)
                        }
                        .onTapGesture {
                            self.showModal = true
                        }
                        .padding()
                        .background(
                            Circle()
                                .foregroundColor(.white)
                                .shadow(color: .gray, radius: 1, x: 1, y: 1)
                        )
                        .overlay(
                            Circle()
                                .stroke(lineWidth: 1)
                                .foregroundColor(.white)
                        )
                        Text("\(today, formatter: WritingView.dateFormat)")
                            .environment(\.locale, Locale(identifier: "ko_KR"))
                            .foregroundColor(Color(hex: 0x555555))
                        
                        
                    }
                    VStack{
                        TextField("Title", text: $memoTitle)
                            .padding()
                            .bold()
                            .foregroundColor(.green)
                            .cornerRadius(10)
                        
                        TextEditor(text: $memoContent)
                            .scrollContentBackground(.hidden)
                            .background(.clear)
                            .padding(.leading)
                            .cornerRadius(10)
                            .lineSpacing(10)
                    }.toolbar {
                        ToolbarItem(placement: .keyboard) {
                            HStack {
                                Button("Tab") {
                                    memoContent = memoContent + "    "
                                }
                                .foregroundColor(.black)
                                .padding()
                                
                                Spacer()
                                
                                Button("Bold") {
                                    
                                }
                                .padding()
                                .foregroundColor(.black)
                                
                            }
                        }
                    }
                }.onTapGesture {
                    doneStatus = true
                    
                }
                .padding()
                .toolbar {
                    
                    Button(action: {
                        if(doneStatus == true){
                            addMemo()
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil) // 키보드를 숨깁니다.
                        } else {
                            print("\(doneStatus)")
                        }
                        
                        doneStatus.toggle()
                        print("Memo Save : Done Tapped")
                        
                    }, label: {
                        Text(doneStatus ? "Done" : "Edit")
                            .bold()
                            .foregroundColor(.green)
                    })
                    
                }
            }
        } .navigationBarBackButtonHidden(doneStatus) // doneStatus가 false일 때 뒤로 가기 버튼 나오게
        
    }
    
    func addMemo() {
        let memo = Memo(title: memoTitle, content: memoContent, emoji: selectedEmoji, time: today)
        modelContext.insert(memo)
    }
    
    func updateMemo() {
        
    }
    /*
     func deleteMemo(_ memo: Memo) {
     modelContext.delete(memo)
     }
     */
    
}

#Preview {
    WritingView()
}
