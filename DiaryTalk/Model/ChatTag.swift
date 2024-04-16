
import Foundation
import SwiftData

@Model
final class ChatTag {
    
    var chatTag: String
    
    var chat: Chat?
    
    init(chatTag: String) {
        self.chatTag = chatTag
    }
}
