//
//  Location.swift
//  patient-feedback-portal
//
//  Created by Jeff Norton on 11/7/21.
//

import Foundation

enum AddressUseType: String {
    case home
    case work
    case otherUse = "other"
}

enum StateProvince: String {
    // Canada
    case ontario
    case quebec
    
    // France
    
    
    // Ireland
    
    
    // United Kingdom
    case essex
    case greaterLondon
    case hampshire
    case kent
    
    // United States
    case california
    case illinois
    case utah
}

enum Country: String {
    case canada
    case france
    case ireland
    case unitedKingdom
    case unitedStates
    
    var shortAbbreviation: String {
        var _abbreviation = ""
        
        switch self {
        case .canada: _abbreviation = "CA"
        case .france: _abbreviation = "FR"
        case .ireland: _abbreviation = "IE"
        case .unitedKingdom: _abbreviation = "GB"
        case .unitedStates: _abbreviation = "US"
        }
        
        return _abbreviation
    }
    
    var longAbbreviation: String {
        var _abbreviation = ""
        
        switch self {
        case .canada: _abbreviation = "CAN"
        case .france: _abbreviation = "FRA"
        case .ireland: _abbreviation = "IRL"
        case .unitedKingdom: _abbreviation = "GBR"
        case .unitedStates: _abbreviation = "USA"
        }
        
        return _abbreviation
    }
}

struct Address {
    var type: AddressUseType
    var line1: String
    var line2: String?
    var city: String
    var stateProvince: StateProvince
    var zipPostalCode: String
    var country: Country
}
