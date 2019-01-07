//
//  Launch.swift
//  SpaceXAppRemake
//
//  Created by Perez Willie Nwobu on 1/6/19.
//  Copyright © 2019 Perez Willie Nwobu. All rights reserved.
//

import Foundation
struct Json_Base : Codable {
    let mission_name : String?
    let mission_id : [String]?
    let launch_date_local : String?
    let rocket : Rocket?
    let links : Links?
    let details : String?
}

//Son of Json Base
struct Rocket : Codable {
    let rocket_id : String?
    let rocket_name : String?
    let rocket_type : String?
   
    let second_stage : Second_stage?
}

//Son of Json Base
struct Links: Codable {
    let mission_patch : String?
    let flickr_images : [String]?
}

//SonOfRocket
struct Second_stage: Codable {
   
    let payloads : [Payloads]?
    
    }

//SonOfSecond_Stage
struct Payloads: Codable {
        let payload_id : String?
       let nationality : String?
     let manufacturer : String?
    
}

