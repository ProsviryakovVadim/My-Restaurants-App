//
//  MyRestrauntsTableViewController.swift
//  MyRestaurants
//
//  Created by Vadim on 05.07.16.
//  Copyright © 2016 Vadim Prosviryakov. All rights reserved.
//

import UIKit
import CoreData

class MyRestrauntsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    var myRestaurants: [Restaurants] = []
    var searchController: UISearchController!
    var searchResultsArray: [Restaurants] = []

    
    @IBAction func unwinBackToHomeScreen(segue: UIStoryboardSegue) {}
    
    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController("Restaurants", keyForSort: "name")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Run list restaurants
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let appAllready = userDefaults.boolForKey("appStartListRestaurants")
        
        if appAllready == false {
            
        // Run page information app
        if let pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as? PageViewController {
            self.presentViewController(pageViewController, animated: true, completion: nil)
            }
        }
        
        // Delegate and try Perform fetch
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
            myRestaurants = fetchedResultsController.fetchedObjects as! [Restaurants]
        } catch let error as NSError {
            print("MyRestrauntsTableViewController error: \(error.localizedDescription)")
        }
        
        // Style table
        self.tableView.estimatedRowHeight = 85
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        // Seacrh controller
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // tabBar
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - Search Controller
    func filterContentFor(searchText: String) {
        searchResultsArray = myRestaurants.filter({ (restaurant: Restaurants) -> Bool in
            let machedName = restaurant.name?.rangeOfString(searchText, options:.CaseInsensitiveSearch, range: nil, locale: nil)
            return machedName != nil
        })
    }
    
    // All Changes Search Controller
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        filterContentFor(searchText!)
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return searchController.active ? false : true
    }
    
    // MARK: - Data Source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.active {
            return searchResultsArray.count
        } else {
        return myRestaurants.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MyRestrauntsTableViewCell
        
        let restaurant = (searchController.active) ? searchResultsArray[indexPath.row] : myRestaurants[indexPath.row]
        cell.nameLabel.text     = restaurant.name
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text     = restaurant.type
        cell.thumbnailImageView.image = UIImage(data: restaurant.image!)
        cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.height / 2
        cell.thumbnailImageView.clipsToBounds = true
        
        return cell
    }
    
    // MARK: - Delegate
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
  
        let allSharedAction = UITableViewRowAction(style: .Default, title: "Поделиться") { (UITableViewRowAction, indexPath: NSIndexPath) in
            
            let allSharedActionMenu = UIAlertController(title: nil, message: "Поделиться через", preferredStyle: .ActionSheet)
            let email = UIAlertAction(title: "Email", style: .Default, handler: nil)
            let facebook = UIAlertAction(title: "FaceBook", style: .Default, handler: nil)
            let vk = UIAlertAction(title: "VKontakte", style: .Default, handler: nil)
            let cancel = UIAlertAction(title: "Отменить", style: .Cancel, handler: nil)
            
            allSharedActionMenu.addAction(email)
            allSharedActionMenu.addAction(facebook)
            allSharedActionMenu.addAction(vk)
            allSharedActionMenu.addAction(cancel)
            self.presentViewController(allSharedActionMenu, animated: true, completion: nil)

        }
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Удалить") { (UITableViewRowAction, indexPath: NSIndexPath) in
            
            let restaureantToRemove = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Restaurants
            CoreDataManager.instance.managedObjectContext.deleteObject(restaureantToRemove)
            CoreDataManager.instance.saveContext()
            // self.myRestaurants.removeAtIndex(indexPath.row)
            // self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
        allSharedAction.backgroundColor = UIColor.darkGrayColor()
        
        return [deleteAction, allSharedAction]
    }
    
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailsSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
            let detailViewController = segue.destinationViewController as! DetailViewController
                detailViewController.restaurant = (searchController.active) ? searchResultsArray[indexPath.row] : myRestaurants[indexPath.row]
            }
        }
    }
    
    // MARK: - Fetched Results Controller Delegate
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            if let indexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        case .Update:
            if let indexPath = indexPath {
                 tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                
                // Alternative to my training
                // let restaurant = fetchedResultsController.objectAtIndexPath(indexPath) as! Restaurants
                // let cell = MyRestrauntsTableViewCell()
                // cell.nameLabel.text     = restaurant.name
                // cell.locationLabel.text = restaurant.location
                // cell.typeLabel.text     = restaurant.type
                // cell.thumbnailImageView.image = UIImage(data: restaurant.image!)
                // cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.height / 2
                // cell.thumbnailImageView.clipsToBounds = true
            }
        case .Move:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
            }
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
        }
        
        myRestaurants = controller.fetchedObjects as! [Restaurants]
    }
    
    
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
}
