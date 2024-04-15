
import Foundation
import SwiftUI

struct Emoji: Identifiable {
    let id = UUID()
    let symbol: String
}

struct SelectMoodView: View {
    
    var today = Date()
    
    // CollectionView
    let emojis = [
        Emoji(symbol: "😀"),
        Emoji(symbol: "😂"),
        Emoji(symbol: "😎"),
        Emoji(symbol: "😁"),
        Emoji(symbol: "😭"),
        Emoji(symbol: "🥳"),
        Emoji(symbol: "😇"),
        Emoji(symbol: "🥲"),
        Emoji(symbol: "😡"),
        Emoji(symbol: "😛"),
        Emoji(symbol: "😱"),
        Emoji(symbol: "🥱"),
        Emoji(symbol: "🙄"),
        Emoji(symbol: "🤮"),
        Emoji(symbol: "🤧"),
        Emoji(symbol: "🫠"),
        Emoji(symbol: "😵‍💫"),
        Emoji(symbol: "🤑")
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedEmoji: String
    
    var body: some View{
        NavigationView{
            VStack{
                VStack{
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            dismissModal()
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.gray)
                            /*
                             Image(systemName: "multiply")
                             .resizable()
                             .frame(width: 25, height: 25)
                             */
                            
                        }).padding(.trailing, 10)
                            .padding(.top, 10)
                        
                        
                    }
                    Text("오늘의 기분이 어떠신가요?")
                        .bold()
                        .foregroundColor(.black)
                        .padding()
                        .font(.system(size: 25))
                    
                }
                Spacer()
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(emojis) { emoji in
                            Text(emoji.symbol)
                                .font(.system(size: 50))
                                .font(.largeTitle)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80)
                                .padding(.vertical)
                                .background(.gray.opacity(0.1))
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    selectedEmoji = emoji.symbol
                                    print("Selected Mood : \(selectedEmoji)")
                                    dismissModal()
                                }
                            
                        }
                    }
                    .padding()
                    
                }
            }
        }
    }
    
    func dismissModal() {
        presentationMode.wrappedValue.dismiss()
    }
}

/*
 #Preview {
 SelectMoodView()
 }
 */
