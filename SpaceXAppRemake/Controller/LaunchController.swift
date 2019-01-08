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
  
    var launches : [Launch] = []
    var sortedLaunches : [Launch] = []
    
    let  spaceXurl = "https://api.spacexdata.com/v2/launches/"
    
    func seachForLaunches(completion : @escaping ((Bool)-> Void)){
        guard let url = URL(string: spaceXurl) else {return}
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { print("there was a problem decoding this JSON"); completion(false); return}
            
            
            if let error = error { print(error.localizedDescription); completion(false); return}
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            guard let welcome = try? jsonDecoder.decode(Launches.self, from: data) else { return }
            
            self.launches = welcome.compactMap({$0})
            
            let startDate = "2016-01-12"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: startDate)
            
            self.sortedLaunches = self.launches.filter({$0.launchDateLocal > date!})
            
            print(date!)
            
            self.sortedLaunches.sort(by: {$0.launchDateLocal < $1.launchDateLocal})
            
            print(self.sortedLaunches.compactMap({$0.launchDateLocal}))
            
            completion(true)
        }
        dataTask.resume()
    }
  
}


extension DateFormatter {
     static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
         formatter.calendar = Calendar(identifier: .iso8601)
         formatter.dateStyle = .short
        formatter.locale = Locale.current
        return formatter
    }()
}

