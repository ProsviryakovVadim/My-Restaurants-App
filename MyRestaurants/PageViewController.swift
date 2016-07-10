//
//  PageViewController.swift
//  MyRestaurants
//
//  Created by Vadim on 07.07.16.
//  Copyright © 2016 Vadim Prosviryakov. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var pageHeaders = ["Создавайте", "Найдите"]
    var pageSubHeaders = ["Создайте свой список ресторанов, которые заслуживают вашего внимания", "Найдите и отметьте на карте ваши любимые рестораны"]
    var pageImageContents = ["rest", "map"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Data source
        dataSource = self
        if let firstViewController = self.showViewControllerAtIndex(0) {
        setViewControllers([firstViewController], direction: .Forward, animated: true, completion: nil)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Page View Controller Data Source
    func showViewControllerAtIndex(index: Int) -> ContentPageViewController? {
        if index >= 0 && index < pageHeaders.count {
            if let contentPageViewController = storyboard?.instantiateViewControllerWithIdentifier("ContentPageViewController") as? ContentPageViewController {
                contentPageViewController.imageFile = pageImageContents[index]
                contentPageViewController.header = pageHeaders[index]
                contentPageViewController.subHeader = pageSubHeaders[index]
                contentPageViewController.index = index
                return contentPageViewController as ContentPageViewController
            }
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentPageViewController).index
        index -= 1
        return self.showViewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentPageViewController).index
        index += 1
        return self.showViewControllerAtIndex(index)
    }
    
    // MARK: - Standart Indetification Page
    func next(index: Int) {
        if let nextViewController = self.showViewControllerAtIndex(index + 1) {
            setViewControllers([nextViewController], direction: .Forward, animated: true, completion: nil)
        }
    }
    //  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
    //      return pageHeaders.count
    //  }
    //
    //  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
    //      if let contentPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentPageViewController") as? ContentPageViewController {
    //      return contentPageViewController.index
    //  }
    //      return 0
    // }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
