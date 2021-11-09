//
//  Common.swift
//  patient-feedback-portal
//
//  Created by Jeff Norton on 11/7/21.
//

import Foundation

// Bundle: Collection class of the various entries (specific resources, such as patients, doctors, appointments, and diagnoses)


class Bundle {
 /*
    var timestamp: Date
    var entries: [Resource]
    
    init(
        resourceType: ResourceType,
        id: String,
        timestamp: String,
        entries: [Resource]) {
        
        let dateFormatter = ISO8601DateFormatter()
        self.timestamp = dateFormatter.date(from: timestamp) ?? Date()
        self.entries = entries
            
        super.init(resourceType: resourceType, id: id)
    }
    
    var description: String {
        var entryDescriptions = ""
        var isFirstEntry = true
        for entry in entries {
            if isFirstEntry {
                entryDescriptions.append("[\n\t\t")
                isFirstEntry = false
            } else {
                entryDescriptions.append(",\n\t\t")
            }
            
            entryDescriptions.append("\(entry.description)")
        }
        entryDescriptions.append("\n\t]")
        
        let _description = "\t• Resource type: \(resourceType.rawValue)\n" +
                            "\t• ID: \(id)\n" +
                            "\t• Timestamp: \(id)\n" +
                            "\t• Codes: \(timestamp)\n" +
                            "\t• entries: \(entryDescriptions)\n"
        
        return _description
    }
  */
}

// References: High-level (super class) related to elements which have a reference to other elements (e.g. diagnosis --> appointment)
class Reference {
    var reference: String
    
    init(_ reference: String) {
        self.reference = reference
    }
    
    var description: String {
        return "{reference: \(reference)}"
    }
}

enum ReferenceType: String {
    // _Errors
    case invalid = "Invalid"
    
    // Events
    case appointment = "Appointment"
    
    // People
    case actor = "Actor"
    case subject = "Subject"
}

// Resource: High-level (super class) object

struct Resource: Codable {
    var resourceItem: ResourceItem
    
    enum CodingKeys: String, CodingKey {
        case resourceItem = "resource"
    }
    
    init(from decoder: Decoder) throws {
        print("[Resource] init(from:) - start")
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let _resourceItem = try container.decode(ResourceItem.self, forKey: .resourceItem)
        switch _resourceItem.resourceType {
        case .doctor:
            print("\t.doctor case")
            resourceItem = try Doctor(from: decoder)
//            resourceItem = _resourceItem as! Doctor
        default:
            print("\tdefault case")
            resourceItem = try Doctor(from: decoder)
        }
        
        print("[Resource] init(from:) - end")
    }
    
    func encode(to encoder: Encoder) throws {
        print("[Resource] encode(to:) - start")
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(resourceItem, forKey: .resourceItem)
        
        print("[Resource] encode(to:) - end")
    }
}

class ResourceItem: Codable {
    var resourceType: ResourceType = .patient
    var id: String = ""
    
    var description: String {
        var _description = ""
        switch resourceType {
        case .doctor:
            _description = "Resource super class"
        default:
            _description = "ResourceItem base class"
        }
        
        return _description
    }

    enum CodingKeys: String, CodingKey {
        case resourceType
        case id
    }

    init(resourceType: ResourceType, id: String) {
        self.resourceType = resourceType
        self.id = id
    }

    required init(from decoder: Decoder) throws {
        print("[ResourceItem] init(from:) - start")
        
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let resourceTypeValue = try container.decode(String.self, forKey: .resourceType)
        resourceType = ResourceType(rawValue: resourceTypeValue) ?? .invalid
        id = try container.decode(String.self, forKey: .id)
        
        print("[ResourceItem] init(from:) - end")
    }

    func encode(to encoder: Encoder) throws {
        print("[ResourceItem] encode(to:) - start")
        
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(resourceType.rawValue, forKey: .resourceType)
        try container.encode(id, forKey: .id)
        
        print("[ResourceItem] encode(to:) - end")
    }
}

enum ResourceType: String {
    // _General
    case bundle
    
    // Errors
    case invalid = "Invalid"
    
    // Action
    case diagnosis = "Diagnosis"
    
    // Event
    case appointment = "Appointment"
    
    // Item
    case prescription = "Prescription"
    
    // Person
    case doctor = "Doctor"
    case patient = "Patient"
}
