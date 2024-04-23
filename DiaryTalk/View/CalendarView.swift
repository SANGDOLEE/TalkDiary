
import Foundation
import SwiftUI

struct CalendarView: View {
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    
                    HStack{
                        CalenderView()
                    }
                    
                    HStack{
                        Text("이번달 일기")
                            .bold()
                            .font(.title)
                        Spacer()
                        Text("올해 일기 ")
                            .bold()
                            .font(.title)
                    }
                    .padding()
                    
                    GeometryReader { geometry in
                        HStack {
                            HStack {
                                Spacer()
                                Text("3")
                                    .padding()
                                    .bold()
                                Spacer()
                            }
                            .background(Color.white)
                            .cornerRadius(20) // 내부 HStack에도 corner radius 적용
                            .frame(width: geometry.size.width / 2, height: 35) // 크기를 명시적으로 설정
                            
                            // 두 번째 HStack
                            HStack {
                                Spacer()
                                Text("hh")
                                    .padding()
                                    .bold()
                                
                                Spacer()
                            }
                            .background(Color.white)
                            .cornerRadius(20) // 내부 HStack에도 corner radius 적용
                            .frame(width: geometry.size.width / 2, height: 35) // 크기를 명시적으로 설정
                        }
                    }
                    Spacer()
                }.padding()
            }
            .background(Color(hex:0xEAEAEC))
            .navigationTitle("History")
        }
    }
}

#Preview{
    CalendarView()
}
