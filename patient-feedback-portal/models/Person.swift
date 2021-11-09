//
//  Name.swift
//  patient-feedback-portal
//
//  Created by Jeff Norton on 11/7/21.
//

import Foundation

// Person

struct Name: Codable {
    var text: String?
    var family: String
    var given: [String]
    
    var description: String {
        let textString = text == nil ? "" : "text: \(String(describing: text)), "
        return "{\(textString)family: \(family), given: \(given)}"
    }
}

struct Names: Codable {
    var names: [Name]
}

// Contacts

enum ContactSystemType: String {
    case email
    case phone
    case twitter
}

protocol ContactUseType { }

enum ContactUseEmailType: String, ContactUseType {
    case personal
    case work
    case otherUse = "other"
}

enum ContactUsePhoneType: String, ContactUseType {
    case home
    case mobile
    case work
    case otherUse = "other"
}

struct Contact {
    var system: ContactSystemType
    var value: String
    var use: ContactUseType
}

enum GenderType: String {
    case female = "Female"
    case male = "Male"
}

class Patient: ResourceItem {
    var active: Bool = false
    var names: [Name]
    var contacts: [Contact]
    var gender: GenderType
    var birthdate: Date
    var addresses: [Address]
    
    enum CodingKeys: String, CodingKey {
        case active
        case names = "name"
        case contacts = "contact"
        case gender
        case birthdate
        case addresses = "address"
    }
    
    init(resourceType: ResourceType, id: String, active: Bool = false, names: [Name], contacts: [Contact], gender: GenderType, birthdate: Date, addresses: [Address]) {
        self.active = active
        self.names = names
        self.contacts = contacts
        self.gender = gender
        self.birthdate = birthdate
        self.addresses = addresses
        
        super.init(resourceType: resourceType, id: id)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        active = true
        names = [Name]()
        contacts = [Contact]()
        gender = .female
        
        let dateFormatter = ISO8601DateFormatter()
        birthdate = dateFormatter.date(from: "1955-01-06") ?? Date()
        addresses = [Address]()
        
        /*
        names = try container.decode([Name].self, forKey: .names)
        print("2")
        federalLicenseNumber = try? container.decode(String.self, forKey: .federalLicenseNumber)
        print("3")
        if let titleString = try? container.decode(String.self, forKey: .title) {
            title = ProviderTitleType(rawValue: titleString) ?? .unknown
        }
         */
        try super.init(from: decoder)
        
        print("[Doctor] init(from:) - end")
    }
    
    override var description: String {
        var nameDescriptions = ""
        var isFirstName = true
        for name in names {
            if isFirstName {
                nameDescriptions.append("[\n\t\t")
                isFirstName = false
            } else {
                nameDescriptions.append(",\n\t\t")
            }
            
            nameDescriptions.append(name.description)
        }
        nameDescriptions.append("\n\t]")
                
        let _description = "\t• Resource type: \(resourceType.rawValue)\n" +
                            "\t• ID: \(id)\n" +
                            "\t• Active: \(active)\n" +
                            "\t• Names: \(nameDescriptions)\n" +
                            "\t• Gender: \(gender.rawValue)\n" +
                            "\t• Birthdate: \(birthdate)"
        
        return _description
    }
}

// Provider

enum ProviderTitleType: String {
    case md = "M.D."
    case na = "N/A"
    case np = "N.P."
    case pa = "P.A"
    case unknown = "Unknown"
}

class Doctor: ResourceItem {
    var names: [Name]
    var federalLicenseNumber: String?
    var title: ProviderTitleType?
    
    enum CodingKeys: String, CodingKey {
//        case resourceType
//        case id
        case names = "name"
        case federalLicenseNumber
        case title
    }
    
    override var description: String {
        var nameDescriptions = ""
        var isFirstName = true
        for name in names {
            if isFirstName {
                nameDescriptions.append("[\n\t\t")
                isFirstName = false
            } else {
                nameDescriptions.append(",\n\t\t")
            }
            
            var nameDescription = "\(name.description), signature: \(name.given.first ?? "") \(name.family)"
            if let title = title {
                nameDescription += ", \(title.rawValue)"
            }
            if let federalLicenseNumber = federalLicenseNumber {
                nameDescription += " [Fed Lic #: \(federalLicenseNumber)]"
            }
            nameDescriptions.append("\(nameDescription)")
        }
        nameDescriptions.append("\n\t]")
                
        let _description = "\t• Resource type: \(resourceType.rawValue)\n" +
                            "\t• ID: \(id)\n" +
                            "\t• Names: \(nameDescriptions)\n"
        
        return _description
    }
    
    init(resourceType: ResourceType, id: String, names: [Name], federalLicenseNumber: String?, title: ProviderTitleType?) {
        self.names = names
        self.federalLicenseNumber = federalLicenseNumber
        self.title = title
        
        super.init(resourceType: resourceType, id: id)
    }
    
    required init(from decoder: Decoder) throws {
        print("[Doctor] init(from:) - start")
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        print("1")
        names = try container.decode([Name].self, forKey: .names)
        print("2")
        federalLicenseNumber = try? container.decode(String.self, forKey: .federalLicenseNumber)
        print("3")
        if let titleString = try? container.decode(String.self, forKey: .title) {
            title = ProviderTitleType(rawValue: titleString) ?? .unknown
        }
        print("4")
        try super.init(from: decoder)
        
        print("[Doctor] init(from:) - end")
    }
    
    override func encode(to encoder: Encoder) throws {
        print("[Doctor] encode(to:) - start")
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(names, forKey: .names)
        try container.encode(federalLicenseNumber, forKey: .federalLicenseNumber)
        if let title = title {
            try container.encode(title.rawValue, forKey: .title)
        }
        
        try super.encode(to: encoder)
        print("[Doctor] encode(to:) - end")
    }
}
