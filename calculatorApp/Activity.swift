//
//  Activity.swift
//  calculatorApp
//
//  Created by Maxos on 4/9/23.
//

import Foundation

enum Activity: CaseIterable {
    case none
    case low
    case medium
    case high
    
    var title: String {
        switch self {
        case .none:
            return "None"
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }
    
    var value: Int {
        switch self {
        case .none:
            return 0
        case .low:
            return 50
        case .medium:
            return 150
        case .high:
            return 250
        }
    }
}
