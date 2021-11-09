//
//  SurveyPatientView.swift
//  patient-feedback-portal
//
//  Created by Jeff Norton on 11/7/21.
//

import UIKit

class SurveyPatientView: UIView {

    // Properties
    
//    var patient: Patient
    var test: String = "" {
        didSet {
            configureUI()
        }
    }
    
    // Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var relationshipLabel: UILabel!
    @IBOutlet weak var pillStackView: UIStackView!
    @IBOutlet weak var readyPillView: UIStackView!
    @IBOutlet weak var readySurveyCountLabel: UILabel!
    @IBOutlet weak var inProcessPillView: UIStackView!
    @IBOutlet weak var inProcessSurveyCountLabel: UILabel!
    
    // Methods
    
    private func configureUI() {
        
    }
}
