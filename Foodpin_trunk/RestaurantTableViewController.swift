//
//  RestaurantTableViewController.swift
//  Foodpin_trunk
//
//  Created by Aman on 2019/6/26.
//  Copyright © 2019 Aman. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisi", "Petite Oyster",
                           "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate",
                           "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli",
                           "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina",
                           "Donostia", "Royal Oak", "Cask Pub and Kitchen"]
    var restaurantImage = [ "cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkeerestaurant",
                            "posatelier", "bourkestreetbakery", "haighschocolate", "palominoespresso",
                            "upstate", "traif", "grahamavenuemeats", "wafflewolf", "fiveleaves",
                            "cafelore", "confessional", "barrafina", "donostia", "royaloak", "caskpubkitchen"]
    
    var restaurantLocations = ["Hong Kong","Hong Kong","Hong Kong","Hong Kong","Hong Kong","Hong Kong","Hong Kong","Sydney","Sydney","Sydney","New York","New York","New York","New York","New York","New York","New York",
                               "London","London","London","London",]
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French" ,
                           "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood" ,"American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea","Latin American", "Spanish", "Spanish", "Spanish", "Britsh", "Thai"]
    var restaurantVisited = Array(repeating: false , count: 21)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurantNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
     
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        cell.nameLabel.text = restaurantNames[indexPath.row]
        cell.typeLabel.text = restaurantTypes[indexPath.row]
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: restaurantImage[indexPath.row] )
        
        cell.accessoryType = restaurantVisited[indexPath.row] ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableview: UITableView, didSelectRowAt indexPath: IndexPath){
        //建立選單作為動作清單
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        
        // 加入動作至選單之中
        let checkinAction = UIAlertAction(title: "Check in", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            let cell =   tableview.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            self.restaurantVisited[indexPath.row] = true
        })
        optionMenu.addAction(checkinAction)

        
        let callActionHandler = { (action: UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        let callAction = UIAlertAction(title: "Call "+"123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
        optionMenu.addAction(callAction)

        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        

        //呈現選單
        present(optionMenu, animated: true , completion: nil)
        
        //取消列的選取
        tableview.deselectRow(at: indexPath, animated: false)
    }

    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
