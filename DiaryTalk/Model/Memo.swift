
import Foundation
import SwiftData

@Model
class Memo: Identifiable {
    
    @Attribute(.unique) var id = UUID()
    
    var title: String
    var content: String
    var emoji: String = ""
    var time: Date = Date()
    
    @Relationship(inverse: \Tag.memo) var tag: [Tag]?
    
    init(title: String, content: String, emoji: String, time: Date){
        self.title = title
        self.content = content
        self.emoji = emoji
        self.time = time
    }
}
