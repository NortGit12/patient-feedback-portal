//
//  MainVC.swift
//  patient-feedback-portal
//
//  Created by Jeff Norton on 11/9/21.
//

import UIKit

class MainVC: UIViewController {
    
    // Properties
    
    @IBOutlet weak var selfContainerView: SurveyPatientView!
    @IBOutlet weak var sonContainerView: SurveyPatientView!
    @IBOutlet weak var fatherContainerView: SurveyPatientView!
    @IBOutlet weak var grandMotherContainerView: SurveyPatientView!
    
    // View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "tendo-background")!) ?? .white
        
        configureUIElements()
    }
    
    // Actions & Selectors
    
    @IBAction func containerViewActionButtonTapped(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let feedbackSurveysVC = mainStoryboard.instantiateViewController(withIdentifier: "FeedbackSurveysVC")
        let feedbackSurveysNC = mainStoryboard.instantiateViewController(withIdentifier: "FeedbackSurveysVC")
        
        // TODO: Pass the model instance to the destination VC
        
        navigationController?.pushViewController(feedbackSurveysNC, animated: true)
    }
    
    // Methods
    
    private func configureUIElements() {
        selfContainerView.layer.cornerRadius = Constants.cornerRadiusMedium
        sonContainerView.layer.cornerRadius = Constants.cornerRadiusMedium
        fatherContainerView.layer.cornerRadius = Constants.cornerRadiusMedium
        grandMotherContainerView.layer.cornerRadius = Constants.cornerRadiusMedium
    }
}
