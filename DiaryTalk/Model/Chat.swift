
import Foundation
import SwiftData
import SwiftUI

@Model
class Chat: Identifiable {
    
    @Attribute(.unique) var id = UUID()
    
    var chatMessage: String
    var chatTime: Date = Date()
    
    @Relationship(inverse: \ChatTag.chat) var chattag: [ChatTag]?
    
    init(chatMessage: String, chatTime: Date){
        self.chatMessage = chatMessage
        self.chatTime = chatTime
    }
    
}

