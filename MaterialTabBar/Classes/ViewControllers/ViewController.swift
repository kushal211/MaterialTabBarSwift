//
//  ViewController.swift
//  MaterialTabBar
//
//  Created by indianic on 27/05/17.
//  Copyright © 2017 Kushal Panchal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    /// @IBOutlet of Container View in which you will be displayed a MDTabBarViewController
    @IBOutlet weak var containerView: UIView!
    
    
    /// Property of MDTabBarViewController
    public var tabBarViewController: MDTabBarViewController?

    
    /// Array of View Controllers
    public lazy var arrViewControllers: [UIViewController] = {
        // The view controllers will be shown in this order
        return [self.getController(id: "SampleVC"),
                self.getController(id: "SampleVC"),
                self.getController(id: "SampleVC"),
                self.getController(id: "SampleVC"),
                self.getController(id: "SampleVC"),
                self.getController(id: "SampleVC")]
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Initialize the object of a tabBarViewController
        loadTabBarController()
        
        // Set as a Child ViewController inside your containerView
        setChildController()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    fileprivate func getController(id: String) -> UIViewController {
        let avc = self.storyboard?.instantiateViewController(withIdentifier: id)
        return avc!
    }
    
    fileprivate func loadTabBarController() -> Void {
        
        if tabBarViewController == nil {
            tabBarViewController = MDTabBarViewController(delegate: self)
            let names: [String] = ["Tab 1", "Sample Tab 2", "Tab 3", "Sample Tab 4", "Tab 5", "Sample Tab 6"]
            tabBarViewController!.setItems(names)
        }
        
    }
    
    fileprivate func setChildController() -> Void {
        
        if tabBarViewController != nil {
            
            // Add as a Child View Controller
            self.addChildViewController(tabBarViewController!)
            self.containerView.addSubview(tabBarViewController!.view)
            tabBarViewController!.didMove(toParentViewController: self)
            
            let controllerView = tabBarViewController!.view!
            
            let viewsDictionary = ["controllerView": controllerView] as [String : Any]
            
            // Add Vertical Constraint
            let arrcons: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[controllerView]-0-|",
                                                                               options: NSLayoutFormatOptions.init(rawValue: 0),
                                                                               metrics: nil,
                                                                               views: viewsDictionary)
            self.view.addConstraints(arrcons)
            
            
            // Add Horizontal Constraint
            let arrcons2: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[controllerView]-0-|",
                                                                                options: NSLayoutFormatOptions.init(rawValue: 0),
                                                                                metrics: nil,
                                                                                views: viewsDictionary)
            self.view.addConstraints(arrcons2)
            
        }
        
    }
    

}



extension ViewController: MDTabBarViewControllerDelegate {
    
    func tabBarViewController(_ viewController: MDTabBarViewController, viewControllerAt index: UInt) -> UIViewController {
        
        let avc = arrViewControllers[Int(index)]
        
        if index % 2 == 0 {
            avc.view.backgroundColor = UIColor.green
        } else {
            avc.view.backgroundColor = UIColor.orange
        }
        
        return avc
        
    }
    
    func tabBarViewController(_ viewController: MDTabBarViewController, didMoveTo index: UInt) {
        print(index)
    }
}


