
import Foundation
import SwiftData

@Model
class Chat: Identifiable {
    
    @Attribute(.unique) var id = UUID()
    
    var chatMessage: String
    
    @Relationship(inverse: \ChatTag.chat) var chattag: [ChatTag]?
    
    init(chatMessage: String){
        self.chatMessage = chatMessage
    }
    
}

