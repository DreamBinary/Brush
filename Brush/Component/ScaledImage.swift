//
//  ScaledImage.swift
//  Brush
//
//  Created by cxq on 2023/6/22.
//
import SwiftUI
struct ScaledImage: View {
    let name: String
    let size: CGSize
    
    var body: Image {
        let uiImage = self.resizedImage(named: self.name, for: self.size) ?? UIImage()
        
        return Image(uiImage: uiImage.withRenderingMode(.alwaysOriginal))
    }
    
    func resizedImage(named: String, for size: CGSize) -> UIImage? {
        guard let image = UIImage(named: named) else {
            return nil
        }
        
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
