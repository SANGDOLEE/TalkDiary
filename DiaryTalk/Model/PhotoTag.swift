
import Foundation
import SwiftData

@Model
final class PhotoTag {
    
    var photoTag: String
    
    var photo: Photo?
    
    init(photoTag: String) {
        self.photoTag = photoTag
    }
    
}

