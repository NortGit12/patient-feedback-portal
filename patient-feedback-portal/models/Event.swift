//
//  Appointment.swift
//  patient-feedback-portal
//
//  Created by Jeff Norton on 11/8/21.
//

import Foundation

enum AppointmentStatus: String {
    case finished
    case scheduled
}

enum AppointmentType: String {
    // Dermatologist
    case dermSkinCheckFull = "Full body skin check"
    
    // Endocronologist
    case endoGeneral = "Endocronologist visit"
}

struct AppointmentPurpose {
    var type: AppointmentType
    
    var description: String {
        return "text: \(type.rawValue)"
    }
}

struct AppointmentPeriod {
    var start: Date
    var end: Date
    
    init(start: String, end: String) {
        let dateFormatter = ISO8601DateFormatter()
        
//        let errorDate = Calendar.current.date(from: DateComponents(timeZone: TimeZone.current, year: 1700, month: 1, day: 1))
        self.start = dateFormatter.date(from: start) ?? Date() //errorDate
        self.end = dateFormatter.date(from: end) ?? Date() //errorDate
    }
    
    var description: String {
        return "{start: \(start), end: \(end)}"
    }
}

class Appointment: ResourceItem {
    var status: AppointmentStatus
    var types: [AppointmentPurpose]
    var subject: Reference
    var actor: Reference
    var period: AppointmentPeriod
    var notes: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case types = "type"
        case subject
        case actor
        case period
        case notes
    }
    
    init(
        resourceType: ResourceType,
        id: String,
        status: AppointmentStatus,
        types: [AppointmentPurpose],
        subject: Reference,
        actor: Reference,
        period: AppointmentPeriod,
        notes: String?) {
            
        self.status = status
        self.types = types
        self.subject = subject
        self.actor = actor
        self.period = period
        self.notes = notes
        
        super.init(resourceType: resourceType, id: id)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        status = .scheduled
        types = [AppointmentPurpose]()
        subject = Reference("Patient/6739ec3e-93bd-11eb-a8b3-0242ac130003")
        actor = Reference("Doctor/9bf9e532-93bd-11eb-a8b3-0242ac130003")
        period = AppointmentPeriod(start: "2021-04-02T11:30:00Z", end: "2021-04-02T12:00:00Z")
        
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
        var typeDescriptions = ""
        var isFirstType = true
        for type in types {
            if isFirstType {
                typeDescriptions.append("[\n\t\t")
                isFirstType = false
            } else {
                typeDescriptions.append(",\n\t\t")
            }
            
            typeDescriptions.append("\(type.description)")
        }
        typeDescriptions.append("\n\t]")
                
        var _description = "\t• Resource type: \(resourceType.rawValue)\n" +
                            "\t• ID: \(id)\n" +
                            "\t• Status: \(status)\n" +
                            "\t• Types: \(typeDescriptions)\n" +
                            "\t• Subject: \(subject.description)\n" +
                            "\t• Actor: \(actor.description)\n" +
                            "\t• Period: \(period.description)\n"
        
        if let notes = notes {
            _description += "\t• Notes: \(notes)"
        }
        
        return _description
    }
}
