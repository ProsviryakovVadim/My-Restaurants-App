//
//  DetailViewController.swift
//  MyRestaurants
//
//  Created by Vadim on 05.07.16.
//  Copyright © 2016 Vadim Prosviryakov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func close(segue: UIStoryboardSegue) {}
    var restaurant: Restaurants!
    var restaurants: [Restaurants] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.restaurantImageView.image = UIImage(data: restaurant.image!)
        self.tableView.backgroundColor = UIColor(colorLiteralRed: 215/255, green: 141/255, blue: 92/255, alpha: 1.0)
        self.tableView.separatorColor = UIColor(red: 201/255, green: 81/255, blue: 0/255, alpha: 1.0)
        title = restaurant.name
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // tabBar
        self.tabBarController?.tabBar.hidden = true

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    // MARK: - Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DetailsTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.keyField.text = "Название"
            cell.valueField.text = restaurant.name
        case 1:
            cell.keyField.text = "Локация"
            cell.valueField.text = restaurant.location
        case 2:
            cell.keyField.text = "Тип"
            cell.valueField.text = restaurant.type
        case 3:
            cell.keyField.text = "Я тут был(а)"
            cell.valueField.text = restaurant.isVisited!.boolValue ? "Да" : "Нет"
        default:
            cell.keyField.text = ""
            cell.valueField.text = ""
        }
        
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    // MARK: - Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 1 {
            self.performSegueWithIdentifier("showTheMap", sender: nil)
        }
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTheMap" {
            let destinationViewController = segue.destinationViewController as! MapRestaurantLocationViewController
            destinationViewController.restaurant = restaurant
        }
//        else if segue.identifier == "showTheQuick" {
//            if let indexPath = self.tableView.indexPathForSelectedRow {
//                let detailViewControllers = segue.destinationViewController as! QuickReviewViewController
//                detailViewControllers.restaurant = restaurants[indexPath.row]
//            }
//
//        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRectZero)
    }
}
