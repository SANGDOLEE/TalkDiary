
import Foundation
import SwiftData

@Model
final class Tag {
    
    var tag: String
    
    var memo: Memo? 
    
    init(tag: String) {
        self.tag = tag
    }
}
