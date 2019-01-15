//
//  LaunchDetailViewController.swift
//  SpaceXAppRemake
//
//  Created by Perez Willie Nwobu on 1/7/19.
//  Copyright © 2019 Perez Willie Nwobu. All rights reserved.
//

import UIKit

class LaunchDetailViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    var payLoads : [Payload] = []
    var links : [Links] = []
    
    //TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payLoads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "payloadCell", for: indexPath) as! PayLoadTableViewCell
        
        let payLoad = payLoads[indexPath.row]
        
        cell.ID.text = payLoad.payloadID
        cell.manufacturer.text = payLoad.manufacturer
        cell.nationality.text = payLoad.nationality
        cell.flckRCollectionView.reloadData()
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        loadPayloads()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    var launch : Launch? {
        didSet {
            updateViews()
            loadPayloads()
        }
    }
    
    func updateViews(){
        guard isViewLoaded else {return}
        print("Hello")
        guard let launchReturn = launch else {return}
        guard let rocketReturn = launch?.rocket else {return}
         print("Hello 2")
        //Mark - DRY, calling dateFormatter twice, fix this
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale.current
        
        let date =  dateFormatter.string(from: launch!.launchDateLocal)
        
        missonName.text = "Name : \(launchReturn.missionName)"
        rocketType.text = "Rocket Type : \(rocketReturn.rocketType)"
        launchDate.text = date
        messageLabel.text = launchReturn.details
        
    }
    
    func loadPayloads(){
 guard isViewLoaded else {return}
        guard let launch = launch else {return}
        self.payLoads = ((launch.rocket.secondStage.payloads.compactMap({$0})))
    }
    
    
    func loadLinks(){
        var tempPayLoad : [Payload] = []
        for eachpayLoad in (launch?.rocket.secondStage.payloads)! {
            tempPayLoad.append(eachpayLoad)
        }
    }
    //Properties
    @IBOutlet weak var missonName: UILabel!
    @IBOutlet weak var rocketType: UILabel!
    @IBOutlet weak var launchDate: UILabel!
    @IBOutlet weak var messageLabel: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    let fetchFlickerOP = FetchFilterOperation()
}


extension LaunchDetailViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return launch?.links.flickrImages.count ?? 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! FlickRCollectionViewCell
        
        
        if  let flickRURL = launch?.links.flickrImages[indexPath.row] {
            fetchFlickerOP.fetchFilter(flickRString: flickRURL) { (sucess, image) in
                if sucess {
                    let image = image
                    DispatchQueue.main.async {
                        cell.flickrImage.image = image
                    }
                } 
            }
        } else {
            print("This one aint got no flickR")
            cell.flickrImage.image = UIImage(named: "spaceship")
            return cell
        }
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toVideo" {
            let detailVC = segue.destination as! LaunchViewController

            if let launch = launch {
                detailVC.launch = launch
            }
        }
    }
    
}

//toVideo
