//
//  Gender.swift
//  calculatorApp
//
//  Created by Maxos on 4/9/23.
//

import Foundation

enum Gender: Int, CaseIterable {
    case male = 0
    case female = 1 
    
    var title: String {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        }
    }
}
