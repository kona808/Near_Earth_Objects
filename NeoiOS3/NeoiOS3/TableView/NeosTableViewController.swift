//
//  NeosTableViewController.swift
//  NeoiOS3
//
//  Created by Jacob Perez on 10/4/22.
//

import UIKit

class NeosTableViewController: UITableViewController {
    // Reciever Property
    var neoArray: [NearEarthObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // array assignment is using the closure to pass in the data
        NEOController.fetchNeos { array in
            guard let array = array else { return }
            DispatchQueue.main.async {
                self.neoArray = array
                self.tableView.reloadData()
            }
        }
    }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
            return neoArray.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "neoCell", for: indexPath)
            // Configure the cell...
            let neo = neoArray[indexPath.row]
            cell.textLabel?.text = "\(neo.name)"
            cell.detailTextLabel?.text = "Designation: \(neo.designation), Potentially Hazardous: \(neo.isWorldKiller)"
            return cell
        }
        
        
    
}
