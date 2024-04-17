//
//  SettingVie.swift
//  DiaryTalk
//
//  Created by 이상도 on 4/12/24.
//

import Foundation
import SwiftUI

struct SettingView: View {
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(.yellow), Color(.blue)]),
                                        startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
            
            //Text("세팅뷰 입니다.")
            
            Button(action: {
                print("text")
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                    .bold()
                    .font(.system(size: 30))
            })
        }
    }
    
}

#Preview{
    SettingView()
}
