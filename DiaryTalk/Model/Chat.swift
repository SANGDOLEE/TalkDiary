import SwiftUI
import SwiftData
import PhotosUI

@Model
class Chat: Identifiable {
    
    @Attribute(.unique) var id = UUID()
    
    var chatMessage: String
    var chatTime: Date = Date()
    var chatDay: Date = Date()
    // @Attribute(.externalStorage) var imgData: Data?
    
    @Relationship(inverse: \ChatTag.chat) var chattag: [ChatTag]?
    
    init(chatMessage: String, chatTime: Date, chatDay: Date /*, imgData: Data?*/) {
        self.chatMessage = chatMessage
        self.chatTime = chatTime
        self.chatDay = chatDay
       //  self.imgData = imgData
    }
}
