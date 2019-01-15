//
//  LaunchViewController.swift
//  SpaceXAppRemake
//
//  Created by Perez Willie Nwobu on 1/9/19.
//  Copyright © 2019 Perez Willie Nwobu. All rights reserved.
//

import UIKit
import WebKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
    }
 
    private func playVideo(){
        guard isViewLoaded else {return}
        guard let launch = launch else {return}
        let urlString = launch.links.videoLink
        guard let url = URL(string: urlString!) else {return}
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    var  launch : Launch? {
    didSet {
    playVideo()
    }
    }
}
