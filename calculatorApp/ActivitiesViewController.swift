//
//  ActivitiesViewController.swift
//  calculatorApp
//
//  Created by Maxos on 4/9/23.
//

import UIKit

class ActivitiesViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var activity: Activity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        if let activity = activity {
            label.text = "Activity: \(activity.title), with \(activity.value) calories"
        } else  {
            label.text = "No selected activity"
        }
        
    }
}
