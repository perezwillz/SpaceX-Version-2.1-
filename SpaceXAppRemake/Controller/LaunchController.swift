//
//  LaunchController.swift
//  SpaceXAppRemake
//
//  Created by Perez Willie Nwobu on 1/6/19.
//  Copyright © 2019 Perez Willie Nwobu. All rights reserved.
//

import Foundation

class LaunchController {
    
    static let shared = LaunchController()
  
    var launches : [Json_Base] = []
    
    //ArrayOflaunches
    //URL
    let  spaceXurl = "https://api.spacexdata.com/v2/launches/"
    
    func seachForLaunches(completion : @escaping ((Bool)-> Void)){
        guard let url = URL(string: spaceXurl) else {return}
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
           guard let data = data else { print("there was a problem decoding this JSON"); completion(false); return}
            
            print(data)
                if let error = error { print(error.localizedDescription); completion(false); return}
            
                let decoder = JSONDecoder()
            
            guard let responseMondel = try? decoder.decode([Json_Base].self, from: data) else {
                print("there was a problem decoding JSON data into response model") ; completion(false)  ; return
            }
            var tempLaunches : [Json_Base] = []
            
            for eachLaunch in responseMondel {
                tempLaunches.append(eachLaunch)
            }
            self.launches = tempLaunches
            
            completion(true)
        }
        dataTask.resume()
    }
    
}
