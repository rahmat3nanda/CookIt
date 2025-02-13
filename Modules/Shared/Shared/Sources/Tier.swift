//
//  Tier.swift
//  Shared
//
//  Created by Rahmat Trinanda Pramudya Amar on 13/02/25.
//

import Foundation
import UIKit

public enum Tier: String, Codable {
    case common
    case rare
    case epic
    
    public var name: String { rawValue.capitalized }
    
    public var color: UIColor {
        switch self {
        case .common: .blue
        case .rare: .purple
        case .epic: .red
        }
    }
}
