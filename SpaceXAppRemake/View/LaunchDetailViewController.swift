//
//  LaunchDetailViewController.swift
//  SpaceXAppRemake
//
//  Created by Perez Willie Nwobu on 1/7/19.
//  Copyright © 2019 Perez Willie Nwobu. All rights reserved.
//

import UIKit

class LaunchDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    updateViews()
    }
    
    var launch : Json_Base? {
        didSet {
            updateViews()
        }
    }

    func updateViews(){
        guard isViewLoaded else {return}
        
        
        
        guard let launchReturn = launch else {return}
        guard let rocketReturn = launch?.rocket else {return}
        
        missonName.text = "Mission Name : \(launchReturn.mission_name)"
        rocketType.text = "Rocket Type : \(rocketReturn.rocket_type)"
        launchDate.text = "Launch Date : \(launchReturn.launch_date_local)"
        messageLabel.text = launchReturn.details
    }
   
//Properties
    @IBOutlet weak var missonName: UILabel!
    @IBOutlet weak var rocketType: UILabel!
    @IBOutlet weak var launchDate: UILabel!
    @IBOutlet weak var messageLabel: UITextView!
    
}
