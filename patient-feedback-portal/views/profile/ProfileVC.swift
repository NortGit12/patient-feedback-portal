//
//  ProfileVC.swift
//  patient-feedback-portal
//
//  Created by Jeff Norton on 11/6/21.
//

import UIKit

class ProfileVC: UIViewController {
    
    // Properties
    
    var originalFirstName = ""
    var originalLastName = ""
    var originalHeightFeet = 0
    var originalHeightInches = 0
    var originalWeight = 0
    
    var saveButtonEnabled: Bool {
        return originalFirstName != firstNameTextField.text ||
        originalLastName != lastNameTextField.text ||
        originalHeightFeet != Int(heightFeetPickerView.selectedRow(inComponent: 0)) ||
        originalHeightInches != Int(heightInchesPickerView.selectedRow(inComponent: 0)) ||
        originalWeight != Int(weightPickerView.selectedRow(inComponent: 0))
    }
    
    // Outlets
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    // Gender
    @IBOutlet weak var heightContainerView: UIView!
    @IBOutlet weak var heightFeetPickerView: UIPickerView!
    @IBOutlet weak var heightInchesPickerView: UIPickerView!
    @IBOutlet weak var weightContainerView: UIView!
    @IBOutlet weak var weightPickerView: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    
    // View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUIElements()
        loadValues()
    }
    
    // Actions & Selectors
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        
        if let firstName = firstNameTextField.text {
            defaults.set(firstName, forKey: "ProfileFirstName")
            originalFirstName = firstName
        }
        
        if let lastName = lastNameTextField.text {
            defaults.set(lastName, forKey: "ProfileLastName")
            originalLastName = lastName
        }
        
        let selectedFeet = heightFeetPickerView.selectedRow(inComponent: 0)
        if originalHeightFeet != selectedFeet {
            defaults.set(Int(selectedFeet), forKey: "ProfileFeet")
            originalHeightFeet = selectedFeet
        }
        
        let selectedInches = heightInchesPickerView.selectedRow(inComponent: 0)
        if originalHeightInches != selectedInches {
            defaults.set(Int(selectedInches), forKey: "ProfileInches")
            originalHeightInches = selectedInches
        }
        
        let selectedWeight = weightPickerView.selectedRow(inComponent: 0)
        if originalWeight != selectedWeight {
            defaults.set(Int(selectedWeight), forKey: "ProfileWeight")
            originalWeight = selectedWeight
        }
        
        saveButton.isEnabled = saveButtonEnabled
    }
    
    // Methods
    
    private func configureUIElements() {
        firstNameTextField.delegate = self
        
        lastNameTextField.delegate = self
        
        heightContainerView.layer.cornerRadius = Constants.cornerRadiusMedium
        
        heightFeetPickerView.dataSource = self
        heightFeetPickerView.delegate = self
        
        heightInchesPickerView.dataSource = self
        heightInchesPickerView.delegate = self
        
        weightContainerView.layer.cornerRadius = Constants.cornerRadiusMedium
        
        weightPickerView.dataSource = self
        weightPickerView.delegate = self
        
        saveButton.layer.cornerRadius = 6.0
        saveButton.isEnabled = false
    }
    
    private func loadValues() {
        let defaults = UserDefaults.standard
        
        if let savedFirstName = defaults.string(forKey: "ProfileFirstName") {
            firstNameTextField.text = savedFirstName
            originalFirstName = savedFirstName
        }
        
        if let savedLastName = defaults.string(forKey: "ProfileLastName") {
            lastNameTextField.text = savedLastName
            originalLastName = savedLastName
        }
        
        if defaults.object(forKey: "ProfileFeet") != nil {
            let savedHeightFeet = defaults.integer(forKey: "ProfileFeet")
            heightFeetPickerView.selectRow(Constants.heightsFeet[savedHeightFeet], inComponent: 0, animated: true)
            originalHeightFeet = savedHeightFeet
        }
        
        if defaults.object(forKey: "ProfileInches") != nil {
            let savedHeightInches = defaults.integer(forKey: "ProfileInches")
            heightInchesPickerView.selectRow(Constants.heightsInches[savedHeightInches], inComponent: 0, animated: true)
            originalHeightInches = savedHeightInches
        }
        
        if defaults.object(forKey: "ProfileWeight") != nil {
            let savedWeight = defaults.integer(forKey: "ProfileWeight")
            weightPickerView.selectRow(Constants.weights[savedWeight], inComponent: 0, animated: true)
            originalWeight = savedWeight
        }
    }
}

extension ProfileVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var rowQuantity = 0
        
        if pickerView == heightFeetPickerView {
            rowQuantity = Constants.heightsFeet.count
        } else if pickerView == heightInchesPickerView {
            rowQuantity = Constants.heightsInches.count
        } else if pickerView == weightPickerView {
            rowQuantity = Constants.weights.count
        }
        
        return rowQuantity
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var value = ""
        
        if pickerView == heightFeetPickerView {
            value = String(Constants.heightsFeet[row])
        } else if pickerView == heightInchesPickerView {
            value = String(Constants.heightsInches[row])
        } else if pickerView == weightPickerView {
            value = String(Constants.weights[row])
        }
        
        return value
    }
}

extension ProfileVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        saveButton.isEnabled = saveButtonEnabled
    }
}

extension ProfileVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveButton.isEnabled = saveButtonEnabled
    }
}
