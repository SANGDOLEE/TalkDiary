
import Foundation
import SwiftUI
import PhotosUI

struct PhotoTest: View {
    
    @State private var images: [UIImage] = []
    @State private var photosPickerItems: [PhotosPickerItem] = []
    
    var body: some View{
        
        VStack{
            PhotosPicker("SelectPhoto", selection: $photosPickerItems, maxSelectionCount: 5, selectionBehavior: .ordered)
                .foregroundColor(.clear)
            
            ScrollView{
                HStack(spacing:20) {
                    ForEach(0..<images.count, id:\.self) { i in
                        Image(uiImage: images[i])
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(.circle)
                    }
                }
            }
        }
        .padding(30)
        .onChange(of: photosPickerItems) { _ , _ in
            Task {
                for item in photosPickerItems {
                    if let data = try? await item.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: data) {
                            images.append(image)
                        }
                    }
                }
                photosPickerItems.removeAll()
            }
        }
    }
}

public extension UITextField {
    
    func setPlaceholderColor(_ placeholderColor: UIColor) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                .foregroundColor: placeholderColor,
                .font: font
            ].compactMapValues { $0 }
        )
    }
}
