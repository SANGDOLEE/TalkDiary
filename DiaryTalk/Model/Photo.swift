import Foundation
import SwiftData
import SwiftUI

@Model
class Photo: Identifiable {
    
    @Attribute(.unique) var id = UUID()
    
    @Attribute(.externalStorage) var photo: Data?
    
    @Relationship(inverse: \PhotoTag.photo) var chattag: [PhotoTag]?
    
    init(photo: Data){
        self.photo = photo
    }
    
}
