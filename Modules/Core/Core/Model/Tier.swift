//
//  Tier.swift
//  Shared
//
//  Created by Rahmat Trinanda Pramudya Amar on 13/02/25.
//

import Foundation
import UIKit

public enum Tier: String, Codable, CaseIterable {
    case common
    case rare
    case epic
    case legendary
    
    public var name: String { rawValue.capitalized }
    
    public var color: UIColor {
        switch self {
        case .common: .blue
        case .rare: .purple
        case .epic: .red
        case .legendary: .black
        }
    }
    
    public var rate: Double {
        switch self {
        case .common: 0.5
        case .rare: 0.3
        case .epic: 0.15
        case .legendary: 0.05
        }
    }
}
