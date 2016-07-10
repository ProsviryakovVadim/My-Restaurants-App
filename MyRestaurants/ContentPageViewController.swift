//
//  ContentPageViewController.swift
//  MyRestaurants
//
//  Created by Vadim on 07.07.16.
//  Copyright © 2016 Vadim Prosviryakov. All rights reserved.
//

import UIKit

class ContentPageViewController: UIViewController {

    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subHeaderLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func close(sender: AnyObject) {
        
        // Add "true" if you need one show
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(false, forKey: "appStartListRestaurants")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func nextScreen(sender: AnyObject) {
        let pageViewController = self.parentViewController as! PageViewController
        pageViewController.next(index)
    }
    
    
    
    var index = 0
    var header = ""
    var subHeader = ""
    var imageFile = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        headerLabel.text = header
        headerLabel.textColor = (index == 0) ? UIColor.blackColor() : UIColor.whiteColor()
        subHeaderLabel.text = subHeader
        subHeaderLabel.textColor = (index == 0) ? UIColor.blackColor() : UIColor.whiteColor()
        contentImageView.image = UIImage(named: imageFile)
        pageControl.currentPage = index
        nextButton.hidden = (index == 0) ? false : true
        startButton.hidden = (index == 1) ? false : true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
