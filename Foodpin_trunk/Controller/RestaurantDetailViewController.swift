//
//  RestaurantDetailViewController.swift
//  Foodpin_trunk
//
//  Created by Aman on 2019/7/5.
//  Copyright © 2019 Aman. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var restaurantNameLabel: UILabel!
    @IBOutlet var restaurantTypeLabel: UILabel!
    @IBOutlet var restaurantLocationLabel: UILabel!

    var restaurant_d: Restaurant = Restaurant()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantImageView.image = UIImage(named: restaurant_d.image)
        restaurantNameLabel.text = restaurant_d.name
        restaurantTypeLabel.text = restaurant_d.type
        restaurantLocationLabel.text = restaurant_d.location
        
        navigationItem.largeTitleDisplayMode = .never
        // Do any additional setup after loading the view.
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
