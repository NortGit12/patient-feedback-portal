//
//  Diagnosis.swift
//  patient-feedback-portal
//
//  Created by Jeff Norton on 11/8/21.
//

import Foundation

struct DiagnosisMetaData {
    var lastUpdatedDate: Date
    
    init(lastUpdatedDate: String) {
        let dateFormatter = ISO8601DateFormatter()
        
        self.lastUpdatedDate = dateFormatter.date(from: lastUpdatedDate) ?? Date()
    }
    
    var description: String {
        return "{lastUpdated: \(lastUpdatedDate)}"
    }
}

enum DiagnosisStatusType: String {
    // Order: Linear (e.g. progressive in time)
    case preliminary = "Preliminary"
    case interim = "Interim"
    case final = "Final"
}

struct DiagnosisCode {
    var system: String
    var code: String
    var name: String
    
    var description: String {
        return "{system: \(system), code: \(code), name: \(name)}"
    }
}

class Diagnosis: ResourceItem {
    var meta: DiagnosisMetaData
    var status: DiagnosisStatusType
    var codes: [DiagnosisCode]
    var appointment: Reference
    var notes: String?
    
    enum CodingKeys: String, CodingKey {
        case meta
        case status
        case codes
        case appointment
        case notes
    }
    
    init(
        resourceType: ResourceType,
        id: String,
        meta: DiagnosisMetaData,
        status: DiagnosisStatusType,
        codes: [DiagnosisCode],
        appointment: Reference,
        notes: String?) {
            
        self.meta = meta
        self.status = status
        self.codes = codes
        self.appointment = appointment
        self.notes = notes
        
        super.init(resourceType: resourceType, id: id)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        meta = DiagnosisMetaData(lastUpdatedDate: "2021-04-02T11:51:03Z")
        status = .preliminary
        codes = [DiagnosisCode]()
        appointment = Reference("Appointment/be142dc6-93bd-11eb-a8b3-0242ac130003")
        notes = nil
        
        /*
        let metaString = try? container.decode(DiagnosisMetaData.self, forKey: .meta)
        meta = DiagnosisMetaData(lastUpdatedDate: <#T##String#>)
        let statusString = try? container.decode(DiagnosisStatusType.self, forKey: .status)
        status = DiagnosisStatusType(rawValue: statusString) ?? .preliminary
        codes = try container.decode([DiagnosisCode].self, forKey: .codes)
        appointment = try? container.decode(Reference.self, forKey: .appointment)
        if let notesString = try? container.decode(String.self, forKey: .notes) {
            notes = notesString
        }
        */
        
        try super.init(from: decoder)
        
    }
    
    override var description: String {
        var codeDescriptions = ""
        var isFirstCode = true
        for code in codes {
            if isFirstCode {
                codeDescriptions.append("[\n\t\t")
                isFirstCode = false
            } else {
                codeDescriptions.append(",\n\t\t")
            }
            
            codeDescriptions.append("\(code.description)")
        }
        codeDescriptions.append("\n\t]")
        
        var _description = "\t• Resource type: \(resourceType.rawValue)\n" +
                            "\t• ID: \(id)\n" +
                            "\t• Meta: \(meta.description)\n" +
                            "\t• Status: \(status)\n" +
                            "\t• Codes: \(codeDescriptions)\n" +
                            "\t• Appointment: \(appointment.description)\n"
        
        if let notes = notes {
            _description += "\t• Notes: \(notes)"
        }
        
        return _description
    }
}
