//
//  FetchPhotoOperation.swift
//  SpaceXAppRemake
//
//  Created by Perez Willie Nwobu on 1/7/19.
//  Copyright © 2019 Perez Willie Nwobu. All rights reserved.
//

import Foundation
import UIKit

class FetchIconPhotoOperation : ConcurrentOperation {
    
    init(photoRef: Launch) {
        self.launch = photoRef
    }
    
    var launch : Launch
    
    var image : UIImage?
    private var dataTask: URLSessionDataTask?
    
    override func start() {
        state = .isExecuting
        
        guard let url = URL(string: launch.links.missionPatch!)     else { return }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            defer { self.state = .isFinished }
            if let error = error {
                NSLog("Error retrieving image from url: \(error), Refer to your dataTast in FetchOperation")
                return
            }
            guard let data = data else { return }
            if let downloadedImage = UIImage(data: data) {
                self.image = downloadedImage
            }
        }
        
        dataTask?.resume()
    }
    
    override func cancel() {
        dataTask?.cancel()
        //I will use this to cancel the dataTask method when the user scrolls off the screen.
    }
    
}
