//
//  Tier.swift
//  Shared
//
//  Created by Rahmat Trinanda Pramudya Amar on 13/02/25.
//

import Foundation

public enum Tier: String, Codable {
    case common
    case rare
    case epic
    
    public var name: String { rawValue.capitalized }
}
