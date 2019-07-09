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
        tableView.cellLayoutMarginsFollowReadableWidth = true
        navigationController?.navigationBar.prefersLargeTitles = true
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
        cell.checkImageView.image = UIImage(named: "heart-tick")
        
        //cell.accessoryType = restaurantVisited[indexPath.row] ? .checkmark : .none
        cell.checkImageView.isHidden = restaurantVisited[indexPath.row] ? false : true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive , title: "Delete"){ (action, sourceView, completionHandler) in
            //從資料來源來刪除列
            self.restaurantLocations.remove(at: indexPath.row)
            self.restaurantTypes.remove(at: indexPath.row)
            self.restaurantImage.remove(at: indexPath.row)
            self.restaurantVisited.remove(at: indexPath.row)
            self.restaurantNames.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade )
            
            completionHandler(true)
        }
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let defaultText = "Just checking in at " + self.restaurantNames[indexPath.row]
            
            let activityController: UIActivityViewController
            
            if let imageToShare = UIImage(named: self.restaurantImage[indexPath.row]){
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            }
            else{
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            
            if let popoverController = activityController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath){
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        deleteAction.image = UIImage(named: "delete")
        
        shareAction.backgroundColor = UIColor(red: 254.0/255.0, green: 149.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        shareAction.image = UIImage(named: "share")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        
        let checkAction = UIContextualAction(style: .normal, title: "Check") {
            (action, sourceView, completionHandler) in
            let cell =  tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            self.restaurantVisited[indexPath.row] = (self.restaurantVisited[indexPath.row]) ? false : true
            cell.checkImageView.isHidden = self.restaurantVisited[indexPath.row] ? false :true
            
            completionHandler(true)
            
        }
        
        checkAction.backgroundColor = UIColor(red: 76.0/255.0, green: 231.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        checkAction.image = restaurantVisited[indexPath.row] ? UIImage(named: "undo") : UIImage(named: "tick")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkAction])
        return swipeConfiguration
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurantImageName = restaurantImage[indexPath.row]
                destinationController.restaurantName = restaurantNames[indexPath.row]
                destinationController.restaurantType = restaurantTypes[indexPath.row]
                destinationController.restaurantLocal = restaurantLocations[indexPath.row]
            }
        }
    }
 

}
