//
//  RestaurantTableViewController.swift
//  Foodpin_trunk
//
//  Created by Aman on 2019/6/26.
//  Copyright © 2019 Aman. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    
    var restaurants: [Restaurant] = [
        Restaurant(name: "Cafe Deadend",type: "Coffee & Tea Shop",location: "Hong Kong",image: "cafedeadend",isVisited: false),
        Restaurant(name: "Homei",type: "Cafe",location:"Hong Kong" ,image:"homei" ,isVisited: false),
        Restaurant(name: "Teakha",type: "Tea House",location: "Hong Kong",image: "teakha",isVisited: false),
        Restaurant(name: "Cafe Loisi",type: "Austrian / Causual Drink",location: "Hong Kong",image: "cafeloisl",isVisited: false),
        Restaurant(name: "Petite Oyster",type: "French",location: "Hong Kong",image: "haighschocolate",isVisited: false),
        Restaurant(name: "For Kee Restaurant",type: "Bakery",location: "Hong Kong",image: "palominoespresso",isVisited: false),
        Restaurant(name: "Po's Atelier",type: "Bakery",location: "Hong Kong",image: "posatelier",isVisited: false),
        Restaurant(name: "Bourke Street Bakery",type: "Chocolate",location: "Sydney",image: "bourkestreetbakery",isVisited: false),
        Restaurant(name: "Haigh's Chocolate",type: "Cafe",location: "Sydney",image: "haighschocolate",isVisited: false),
        Restaurant(name: "Palomino Espresso",type: "American / Seafood",location: "Sydney",image: "palominoespresso",isVisited: false),
        Restaurant(name: "Upstate",type: "American",location:"New York" ,image: "upstate",isVisited: false),
        Restaurant(name: "Traif",type: "American",location: "New York",image:"traif" ,isVisited: false),
        Restaurant(name: "Graham Avenue Meats And Deli",type: "Breakfast & Brunch",location:"New York" ,image:"grahamavenuemeats" ,isVisited: false),
        Restaurant(name: "Waffle & Wolf",type: "Coffee & Tea",location:"New York" ,image: "wafflewolf",isVisited: false),
        Restaurant(name: "Five Leaves",type: "Coffee & Tea",location:"New York" ,image: "fiveleaves",isVisited: false),
        Restaurant(name: "Cafe Lore",type: "Latin American",location: "New York",image: "cafelore",isVisited: false),
        Restaurant(name: "Confessional",type: "Spanish",location:"New York" ,image: "confessional",isVisited: false),
        Restaurant(name: "Barrafina",type:"Spanish" ,location:"New York" ,image: "barrafina",isVisited: false),
        Restaurant(name: "Donostia",type: "Spanish",location: "New York",image: "donostia",isVisited: false),
        Restaurant(name: "Royal Oak",type: "Britsh",location:"New York" ,image: "royaloak",isVisited: false),
        Restaurant(name: "Cask Pub and Kitchen",type: "Thai",location: "New York",image: "caskpubkitchen",isVisited: false),
    ]

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
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
     
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        cell.nameLabel.text = restaurants[indexPath.row].name
        cell.typeLabel.text = restaurants[indexPath.row].type
        cell.locationLabel.text = restaurants[indexPath.row].location
        cell.thumbnailImageView.image = UIImage(named: restaurants[indexPath.row].image )
        cell.checkImageView.image = UIImage(named: "heart-tick")
        
        //cell.accessoryType = restaurantVisited[indexPath.row] ? .checkmark : .none
        cell.checkImageView.isHidden = restaurants[indexPath.row].isVisited ? false : true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive , title: "Delete"){ (action, sourceView, completionHandler) in
            //從資料來源來刪除列
            self.restaurants.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade )
            
            completionHandler(true)
        }
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name
            
            let activityController: UIActivityViewController
            
            if let imageToShare = UIImage(named: self.restaurants[indexPath.row].image){
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
            self.restaurants[indexPath.row].isVisited = (self.restaurants[indexPath.row].isVisited) ? false : true
            cell.checkImageView.isHidden = self.restaurants[indexPath.row].isVisited ? false :true
            
            completionHandler(true)
            
        }
        
        checkAction.backgroundColor = UIColor(red: 76.0/255.0, green: 231.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        checkAction.image = restaurants[indexPath.row].isVisited ? UIImage(named: "undo") : UIImage(named: "tick")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkAction])
        return swipeConfiguration
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                
                destinationController.restaurant_d = restaurants[indexPath.row]

            }
        }
    }
 

}
