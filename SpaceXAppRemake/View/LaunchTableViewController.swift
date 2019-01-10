//
//  LaunchTableViewController.swift
//  SpaceXAppRemake
//
//  Created by Perez Willie Nwobu on 1/7/19.
//  Copyright © 2019 Perez Willie Nwobu. All rights reserved.
//

import UIKit

class LaunchTableViewController: UITableViewController {

    let launchController = LaunchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        launchController.seachForLaunches { (sucess) in
            if sucess {
                DispatchQueue.main.async {
                    print(self.launchController.launches.count)
                    self.tableView.reloadData()
                }}}}

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return launchController.sortedLaunches.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LaunchTableViewCell
        
        let launch = launchController.sortedLaunches[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale.current
  
        let date =  dateFormatter.string(from: launch.launchDateLocal)
            cell.missionNameText.text = launch.missionName
       cell.dateText.text = date
        cell.messageText.text = launch.details
        cell.rocketNameText.text = launch.rocket.rocketName.rawValue
        cell.rocketTypeText.text = launch.rocket.rocketType.rawValue
        
        loadImage(forCell: cell, forItemAt: indexPath, launch: launch)
        return cell
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //define initial state(before animation)
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0)
        cell.layer.transform = rotationTransform
        
        //define the final state (after animation)
        UIView.animate(withDuration: 1, animations: {
            cell.layer.transform = CATransform3DIdentity })
        
    }


    //function to lead images with operations
    private func loadImage(forCell cell: LaunchTableViewCell, forItemAt indexPath: IndexPath, launch: Launch ) {
                if let image = cache[launch.missionName] {
            cell.launchImageView.image = image
            
        }
        else {
            //Operation1 : Get Photo
            let op1 = FetchIconPhotoOperation(photoRef: launch)
          
            //Operation2 : SavePhoto
            let op2 = BlockOperation {
                guard let image = op1.image else { return }
                self.cache.cache(value: image, for: launch.missionName)
            }
            
            let op3 = BlockOperation {
                
                guard let image = op1.image else { print("Something went wrong with loading Image PEREZ")
                    ;return }
                
                //making sure we on the right cell
                if indexPath == self.tableView.indexPath(for: cell) {
               
                    cell.launchImageView.image = image
                    
                }else {
                    //Soon as we get off the cell we cancel
                    self.fetchRequests[launch.missionName]?.cancel()
                    
                }
            }
            op3.addDependency(op1)
            op2.addDependency(op1)
            OperationQueue.main.addOperation(op3)
            photoFetchQueue.addOperations([op1, op2], waitUntilFinished: false)
            
            //fetchOperationtrigger
            fetchRequests[launch.missionName] = op1
        }
         
    }
    
    //ExternalProperties
     private var cache: Cache<String, UIImage> = Cache()
    private var photoFetchQueue = OperationQueue()
    private var fetchRequests: [String : FetchIconPhotoOperation] = [:] 
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "toDetailVC" {
            let detailVC = segue.destination as! LaunchDetailViewController
                if let indexPath = tableView.indexPathForSelectedRow {
                 
                    let launch = launchController.sortedLaunches[indexPath.row]
                    detailVC.launch = launch
                }
            }
        }
}
