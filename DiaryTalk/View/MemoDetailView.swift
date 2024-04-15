
import Foundation
import SwiftUI

struct MemoDetailView: View {
    
    let title: String
    let content: String
    let emoji: String
    let time: Date
    
    @State private var selectedEmoji = "" // 선택한 emoji 저장
    
    //  var today = Date()
    @State private var showModal = false // Mood 모달
    @State private var isPresentingEditMemoView = false
    
    init(memo: Memo) { // 저장된 메모를 초기화하면서 받음
        self.title = memo.title
        self.content = memo.content
        self.emoji = memo.emoji
        self.time = memo.time
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.2)
                    .ignoresSafeArea()
                
                VStack {
                    /*
                     Button(action: {
                     self.showModal = true
                     }, label: {
                     Text(emoji)
                     
                     /*
                      if selectedEmoji.isEmpty { // 선택된 Emoji가 없으면 plus 아이콘 표시
                      Image(systemName: "plus")
                      .foregroundColor(Color(hex: 0xE2B100))
                      } else { // 선택된 Emoji가 있으면 해당 Emoji 표시
                      Text(emoji)
                      .font(.system(size: 30))
                      .sheet(isPresented: self.$showModal) {
                      SelectMoodView(selectedEmoji: self.$selectedEmoji)
                      }
                      }
                      */
                     }).disabled(true)
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
                     */
                    HStack{
                        Text("\(time, formatter: WritingView.timeFormat)")
                            .environment(\.locale, Locale(identifier: "ko_KR"))
                            .foregroundColor(.gray.opacity(0.7))
                        Text(emoji)
                    }.padding()
                   
                    
                    VStack{
                        HStack{
                            Text(title)
                                .foregroundColor(Color(hex: 0xE2B100))
                                .bold()
                            
                            Spacer()
                        }.padding()
                        HStack{
                            Text(content)
                            
                            
                            Spacer()
                        }.padding()
                    }
                    Spacer()
                }
            }
        }.navigationBarItems(trailing:
                                Button(action: {
            // Present the EditMemoView modally
            isPresentingEditMemoView = true
        }) {
            Image(systemName: "square.and.pencil")
        }
            .sheet(isPresented: $isPresentingEditMemoView) {
                NavigationView {
                    EditMemoView()
                        .toolbarRole(.editor)
                        .navigationBarItems(leading: Button("Cancel") {
                            isPresentingEditMemoView = false
                        })
                }
            }
        )
        
    }
}

/*
 #Preview {
 MemoDetailView()
 }
 */
