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
        return launchController.launches.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LaunchTableViewCell
        
        let launch = launchController.launches[indexPath.row]
      cell.missionNameText.text = launch.mission_name
        cell.dateText.text = launch.launch_date_local
        cell.messageText.text = launch.details
        cell.rocketNameText.text = launch.rocket?.rocket_name
        cell.rocketTypeText.text = launch.rocket?.rocket_type
        
        loadImage(forCell: cell, forItemAt: indexPath, json_base: launch)
        return cell
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }

    //function to lead images with operations
    private func loadImage(forCell cell: LaunchTableViewCell, forItemAt indexPath: IndexPath, json_base: Json_Base ) {
        
        if let image = cache[json_base.mission_name] {
            cell.launchImageView.image = image
            
        }
        else {
            //Operation1 : Get Photo
            let op1 = FetchIconPhotoOperation(photoRef: json_base)
          
            //Operation2 : SavePhoto
            let op2 = BlockOperation {
                guard let image = op1.image else { return }
                self.cache.cache(value: image, for: json_base.mission_name)
            }
            
            let op3 = BlockOperation {
                
                guard let image = op1.image else { print("Something went wrong with loading Image PEREZ")
                    ;return }
                
                //making sure we on the right cell
                if indexPath == self.tableView.indexPath(for: cell) {
               
                    cell.launchImageView.image = image
                    
                }else {
                    //Soon as we get off the cell we cancel
                    self.fetchRequests[json_base.mission_name]?.cancel()
                    
                }
            }
            op3.addDependency(op1)
            op2.addDependency(op1)
            OperationQueue.main.addOperation(op3)
            photoFetchQueue.addOperations([op1, op2], waitUntilFinished: false)
            
            //fetchOperationtrigger
            fetchRequests[json_base.mission_name] = op1
        }
         
    }
    
    //ExternalProperties
     private var cache: Cache<String, UIImage> = Cache()
    private var photoFetchQueue = OperationQueue()
    private var fetchRequests: [String : FetchIconPhotoOperation] = [:] {
        didSet{
            print("Start fetching Images")
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "toDetailVC" {
            let detailVC = segue.destination as! LaunchDetailViewController
                if let indexPath = tableView.indexPathForSelectedRow {
                    let launch = launchController.launches[indexPath.row]
                    detailVC.launch = launch
                }
            }
        }
}
