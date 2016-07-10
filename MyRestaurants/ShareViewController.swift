//
//  ShareViewController.swift
//  MyRestaurants
//
//  Created by Vadim on 05.07.16.
//  Copyright © 2016 Vadim Prosviryakov. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {

    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var topLeft: UIView!
    @IBOutlet weak var topRight: UIView!
    @IBOutlet weak var bottomLeft: UIView!
    @IBOutlet weak var bottomRight: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        topLeft.transform = CGAffineTransformMakeTranslation(0, -500)
        topRight.transform = CGAffineTransformMakeTranslation(0, -500)
        bottomRight.transform = CGAffineTransformMakeTranslation(0, 500)
        let bottomLeftScale = CGAffineTransformMakeScale(0, 0)
        let bottomLeftTranslation = CGAffineTransformMakeTranslation(0, 500)
        bottomLeft.transform = CGAffineTransformConcat(bottomLeftScale, bottomLeftTranslation)

    }
    
    override func viewDidAppear(animated: Bool) {
        
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.topLeft.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
        
        UIView.animateWithDuration(0.7, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.topRight.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
        
        UIView.animateWithDuration(0.7, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.bottomRight.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
        
        UIView.animateWithDuration(0.7, delay: 0.8, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            let bottomLeftScale = CGAffineTransformMakeScale(1.0, 1.0)
            let bottomLeftTranslation = CGAffineTransformMakeTranslation(0, 0)
            self.bottomLeft.transform = CGAffineTransformConcat(bottomLeftScale, bottomLeftTranslation)
            }, completion: nil)

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
