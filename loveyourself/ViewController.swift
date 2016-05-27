//
//  ViewController.swift
//  loveyourself
//
//  Created by David Fontenot on 5/27/16.
//  Copyright © 2016 David Fontenot. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var animatingView: UIView!
    @IBOutlet weak var animatingLabel: UILabel!

    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!

    var animatingViewOriginalCenter: CGPoint!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //animatingView.
        //print(animatingLabel.center.x)
        //print(view.bounds.width)
        animatingView.center.x  -= view.bounds.width //doesnt work
        //print(animatingLabel.center.x)



        // The onCustomTap: method will be defined in Step 3 below.
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.onCustomPan(_:)))
        //var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
        // set delegate
        panGestureRecognizer.delegate = self
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        animatingView.userInteractionEnabled = true
        animatingView.addGestureRecognizer(panGestureRecognizer)
    }

    func onCustomPan(sender: UIPanGestureRecognizer) {
        let point = sender.locationInView(view)
        let velocity = sender.velocityInView(view)
        let translation = sender.translationInView(view)

        animatingViewOriginalCenter = point

        if sender.state == UIGestureRecognizerState.Began {
            print("Gesture began at: \(point)")
        } else if sender.state == UIGestureRecognizerState.Changed {
            print("Gesture changed at: \(point)")
            animatingView.center = CGPoint(x: animatingViewOriginalCenter.x + translation.x, y: animatingViewOriginalCenter.y + translation.y)
        } else if sender.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")
        }
    }

    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

