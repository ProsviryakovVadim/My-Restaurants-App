//
//  AddRestaurantTableViewController.swift
//  MyRestaurants
//
//  Created by Vadim on 06.07.16.
//  Copyright © 2016 Vadim Prosviryakov. All rights reserved.
//

import UIKit
import CoreData

class AddRestaurantTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!

    var isVisited = false
    var restaurant: Restaurants!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // self.tableView.backgroundColor = UIColor(red: 201/255, green: 81/255, blue: 0/255, alpha: 1.0)
        // self.tableView.separatorColor = UIColor(red: 201/255, green: 81/255, blue: 0/255, alpha: 1.0)
        // yesButton.backgroundColor = UIColor(red: 201/255, green: 81/255, blue: 0/255, alpha: 0.7)
        yesButton.backgroundColor = UIColor(red: 21/255, green: 159/255, blue: 40/255, alpha: 0.5)
        yesButton.layer.cornerRadius = 20
        yesButton.clipsToBounds = true
        noButton.backgroundColor = UIColor.grayColor()
        noButton.layer.cornerRadius = 20
        noButton.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                
                // GCD
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .PhotoLibrary
                imagePicker.delegate = self
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRectZero)
    }
    
    @IBAction func saveRestaurant() {
    
        var error = ""
        
        if nameTextField.text!.isEmpty {
            error = "Название"
        } else if typeTextField.text!.isEmpty {
            error = "Тип"
        } else if locationTextField.text!.isEmpty {
            error = "Расположение"
        }
        
        if error != "" {
            let alert = UIAlertController(title: "Внимание!", message: "Сохранение не удалось, так как поле '\(error)' не заполнено", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
            }
        
        // Add object CoreData
        if restaurant == nil {
        restaurant = Restaurants()
        restaurant.name = nameTextField.text
        restaurant.type = typeTextField.text
        restaurant.location = locationTextField.text
        restaurant.isVisited = isVisited
        restaurant.image = UIImagePNGRepresentation(imageView.image!)
        CoreDataManager.instance.saveContext()
        
        performSegueWithIdentifier("unwinBackToHomeScreen", sender: self)
        
        }
    }
    
    @IBAction func isRestaurantVisited(sender: AnyObject) {
      
        let pressedButton = sender as! UIButton
    
        switch pressedButton {
        case yesButton:
             isVisited = true
             yesButton.backgroundColor = UIColor(red: 21/255, green: 159/255, blue: 40/255, alpha: 0.5)
             noButton.backgroundColor = UIColor.grayColor()
        case noButton:
             isVisited = false
             noButton.backgroundColor = UIColor(red: 21/255, green: 159/255, blue: 40/255, alpha: 0.5)
             yesButton.backgroundColor = UIColor.grayColor()
        default:
            break
        }
    }
    
    // MARK: - Table view data source

    /*override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
