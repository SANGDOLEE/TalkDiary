////
////  TestView.swift
////  DiaryTalk
////
////  Created by 이상도 on 4/17/24.
////
//
//import Foundation
//import SwiftUI
//
//struct TestView: View{
//    
//    
//    @State private var selectedItems: [PhotosPickerItem] = []
//    @State private var selectedPhotosData: [Data] = []
//    
//    var body: some View{
//        
//        NavigationStack {
//         
//            ScrollView {
//                VStack {
//                    ForEach(selectedPhotosData, id: \.self) { photoData in
//                        if let image = UIImage(data: photoData) {
//                            Image(uiImage: image)
//                                .resizable()
//                                .scaledToFit()
//                                .cornerRadius(10.0)
//                                .padding(.horizontal)
//                        }
//                    }
//                }
//            }
//         
//         
//            .navigationTitle("Photos")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    PhotosPicker(selection: $selectedItems, maxSelectionCount: 5, matching: .images) {
//                        Image(systemName: "photo.on.rectangle.angled")
//                    }
//                    .onChange(of: selectedItems) { newItems in
//                        for newItem in newItems {
//         
//                            Task {
//                                if let data = try? await newItem.loadTransferable(type: Data.self) {
//                                    selectedPhotosData.append(data)
//                                }
//                            }
//         
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
