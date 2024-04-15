
import Foundation
import SwiftData

@Model
class Memo: Identifiable {
    
    @Attribute(.unique) var id = UUID()
    
    var title: String // 제목
    var content: String // 내용
    var emoji: String = "" // 기분
    var time: Date = Date() // 날짜
    
    
    
    @Relationship(inverse: \Tag.memo) var tag: [Tag]?
    
    init(title: String, content: String, emoji: String, time: Date){
        self.title = title
        self.content = content
        self.emoji = emoji
        self.time = time
    
    }
    
}
