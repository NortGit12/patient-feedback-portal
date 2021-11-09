//
//  FeedbackSurverysVC.swift
//  patient-feedback-portal
//
//  Created by Jeff Norton on 11/9/21.
//

import UIKit

enum FeedbackSurveySectionType: String, CaseIterable {
    // Order: Process order ascending
    case ready = "Ready"
    case inProcess = "In-Process"
    case completed = "Completed"
    
    var index: Int {
        var _index = 0
        
        switch self {
        case .ready: _index = 0
        case .inProcess: _index = 1
        case .completed: _index = 2
        }
        
        return _index
    }
    
    var color: UIColor {
        var _color = UIColor.black
        
        switch self {
        case .ready: _color = .red
        case .inProcess: _color = .yellow
        case .completed: _color = .green
        }
        
        return _color
    }
}

class FeedbackSurveysVC: UIViewController {
    
    // Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    // View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIElements()
    }
    
    // Methods
    
    private func configureUIElements() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }
}

extension FeedbackSurveysVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return FeedbackSurveySectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numRows = 0
        
        switch section {
        case FeedbackSurveySectionType.ready.index:
            numRows = 2
        case FeedbackSurveySectionType.inProcess.index:
            numRows = 1
        case FeedbackSurveySectionType.completed.index:
            numRows = 2
        default:
            numRows = 0
        }
        
        return numRows
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        
        switch section {
        case FeedbackSurveySectionType.ready.index: title = "\(FeedbackSurveySectionType.ready.rawValue)"
        case FeedbackSurveySectionType.inProcess.index: title = "\(FeedbackSurveySectionType.inProcess.rawValue)"
        case FeedbackSurveySectionType.completed.index: title = "\(FeedbackSurveySectionType.completed.rawValue)"
        default: title = "Unknown"
        }
        
        return title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch indexPath.section {
        case FeedbackSurveySectionType.ready.index:
            if let _cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackSurveyReadyCell") {
                _cell.textLabel?.text = "Ready Survey \((indexPath.row + 1))"
                cell = _cell
            }
        case FeedbackSurveySectionType.inProcess.index:
            if let _cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackSurveyInProcessCell") {
                cell.textLabel?.text = "InProcess Survey \((indexPath.row + 1))"
                cell = _cell
            }
        case FeedbackSurveySectionType.completed.index:
            if let _cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackSurveyCompletedCell") {
                cell.textLabel?.text = "Completed Survey \((indexPath.row + 1))"
                cell = _cell
            }
        default:
            cell.textLabel?.text = "Unknown Survey"
        }
        
        return cell
    }
}

extension FeedbackSurveysVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("Cell \(indexPath.row) in section \(indexPath.section) was selected")
    }
}
