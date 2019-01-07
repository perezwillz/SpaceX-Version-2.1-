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
        
        return cell
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
