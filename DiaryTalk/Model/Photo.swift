import Foundation
import SwiftData
import SwiftUI

@Model
class Photo: Identifiable {
    
    @Attribute var id = UUID()
    
    @Attribute var imageData: Data
    
    init(image: UIImage) {
        self.imageData = image.jpegData(compressionQuality: 1.0) ?? Data()
    }
}
