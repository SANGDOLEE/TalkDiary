import Foundation
import SwiftData
import SwiftUI

@Model
class Photo: Identifiable {
    
    @Attribute(.unique) var id = UUID()

    @Attribute(.externalStorage) var imgData: Data?
    var imgTime: Date = Date()
    
    init(imgData: Data?, imgTime: Date) {
        self.imgData = imgData
        self.imgTime = imgTime
    }
}
