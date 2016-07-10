//
//  AboutUsViewController.swift
//  MyRestaurants
//
//  Created by Vadim on 08.07.16.
//  Copyright © 2016 Vadim Prosviryakov. All rights reserved.
//

import UIKit
import MessageUI

class AboutUsViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBAction func sendMail(sende: AnyObject) {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeVC = MFMailComposeViewController()
            mailComposeVC.mailComposeDelegate = self
            mailComposeVC.setToRecipients(["letrain@yandex.ru"])
            mailComposeVC.navigationBar.tintColor = UIColor.whiteColor()
            presentViewController(mailComposeVC, animated: true, completion: {
                UIApplication.sharedApplication().statusBarStyle = .LightContent
            })
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch  result.rawValue {
        case MFMailComposeResultSaved.rawValue:
            print("Сообщение сохранено")
        case MFMailComposeResultCancelled.rawValue:
            print("Сообщение отменено")
        case MFMailComposeResultSent.rawValue:
            print("Сообщение отправлено")
        case MFMailComposeResultFailed.rawValue:
            print("Сообщение не отправлено")
        default:
            break
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

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
