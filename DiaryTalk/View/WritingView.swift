
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
    
    static let timeFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일 E요일 HH:mm"
        return formatter
    }()
    
    static let monthDayFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일"
        return formatter
    }()
    
    var today = Date()
    @State private var showModal = false // Mood 모달
    
    @State private var showAlert = false // alert
    
    // KeyBoard Tool bar
    @State private var text = ""
    @State private var isBold = false
    
    var body: some View {
        NavigationStack{
            
            ZStack{
                Color.white
                    .ignoresSafeArea()
                
                VStack {
                    VStack{
                        Button(action: {
                            self.showModal = true
                        }, label: {
                            if selectedEmoji.isEmpty { // 선택된 Emoji가 없으면 plus 아이콘 표시
                                Text("🫥")
                                    .font(.system(size: 30))
                                    .foregroundColor(.black)
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
                        .padding(10)
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
                            .foregroundColor(.gray.opacity(0.7))
                    }
                    VStack{
                        TextField("Title", text: $memoTitle)
                            .padding()
                            .padding(.leading, 5)
                            .bold()
                            .foregroundColor(.black)
                            .cornerRadius(10)
                        
                        TextEditor(text: $memoContent)
                            .scrollContentBackground(.hidden)
                            .background(.clear)
                            .padding(.leading, 15)
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
                                Button("*") {
                                    memoContent = memoContent + "*"
                                }
                                .padding()
                                .foregroundColor(.black)
                                
                                Spacer()
                                Button(".") {
                                    memoContent = memoContent + "."
                                }
                                .padding()
                                .foregroundColor(.black)
                                
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
                .toolbar {
                    
                    Button(action: {
                        if doneStatus {
                            if memoTitle.isEmpty && memoContent.isEmpty {
                                showAlert = true
                            } else {
                                // addMemo()
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                doneStatus.toggle()
                                print("Memo Save : Done Tapped")
                            }
                        } else {
                            print("\(doneStatus)")
                        }
                        
                    }, label: {
                        Text(doneStatus ? "Done" : "Edit")
                            .bold()
                    }).alert(isPresented: $showAlert) {
                        Alert(title: Text("알림"), message: Text("제목 혹은 내용을 작성해주세요."), dismissButton: .default(Text("OK")))
                    }
                }
            }
        }
        //.navigationBarBackButtonHidden(doneStatus) // doneStatus가 false일 때 뒤로 가기 버튼 나오게
        .onDisappear(){
            if !memoTitle.isEmpty || !memoContent.isEmpty { // title or content가 하나라도 있어야 저장
                addMemo() // Done을 누르면 최종 Text가 저장만되고 나갈 떄 저장됨 ( 나중에 수정하면 좋다.. )
            }
        }
        
    }
    
    func addMemo() {
        let memo = Memo(title: memoTitle, content: memoContent, emoji: selectedEmoji, time: today)
        modelContext.insert(memo)
    }
    
    //    func deleteMemo(_ memo: Memo) {
    //        modelContext.delete(memo)
    //    }
}

#Preview {
    WritingView()
}
