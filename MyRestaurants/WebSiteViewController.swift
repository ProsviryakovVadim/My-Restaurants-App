//
//  WebSiteViewController.swift
//  MyRestaurants
//
//  Created by Vadim on 08.07.16.
//  Copyright © 2016 Vadim Prosviryakov. All rights reserved.
//

import UIKit

class WebSiteViewController: UIViewController {

    @IBOutlet weak var webSite: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let webSireURL = NSURL(string: "http://www.delivery-club.ru") {
            let webOpenPage = NSURLRequest(URL: webSireURL)
            webSite.loadRequest(webOpenPage)
        }
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
