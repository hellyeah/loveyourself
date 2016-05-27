//
//  ViewController.swift
//  loveyourself
//
//  Created by David Fontenot on 5/27/16.
//  Copyright © 2016 David Fontenot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animatingView: UIView!
    @IBOutlet weak var animatingLabel: UILabel!

    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!

    @IBAction func animateViewWithLabel(sender: AnyObject) {
        // 1
        let newConstraint = NSLayoutConstraint(item: animatingView, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1.0, constant: self.view.frame.width)

        // 2
        UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseOut , animations: {
            self.view.removeConstraint(self.leadingConstraint)
            self.view.addConstraint(newConstraint)
            self.view.layoutIfNeeded()
            }, completion: nil)

        // 3
        leadingConstraint = newConstraint
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //animatingView.
        //print(animatingLabel.center.x)
        //print(view.bounds.width)
        animatingView.center.x  -= view.bounds.width
        //print(animatingLabel.center.x)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

