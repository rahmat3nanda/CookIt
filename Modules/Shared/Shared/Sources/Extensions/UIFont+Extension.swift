//
//  UIFont+Extension.swift
//  Shared
//
//  Created by Rahmat Trinanda Pramudya Amar on 13/02/25.
//

import UIKit

public extension UIFont {
    func rounded() -> UIFont {
        guard let descriptor = fontDescriptor.withDesign(.rounded) else { return self }
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}
