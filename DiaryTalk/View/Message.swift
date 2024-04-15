//
//  Message.swift
//  DiaryTalk
//
//  Created by 이상도 on 4/12/24.
//

import Foundation

struct Message: Identifiable {
    var id = UUID()
    var text: String
    var isFromCurrentUser: Bool
}
