//
//  ViewController.swift
//  loveyourself
//
//  Created by David Fontenot on 5/27/16.
//  Copyright © 2016 David Fontenot. All rights reserved.
//

import UIKit
import KGNAutoLayout

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var animatingView: UIView!
    @IBOutlet weak var animatingLabel: UILabel!
    @IBOutlet weak var loveYourselfButton: UIButton!

    //@IBOutlet weak var leadingConstraint: NSLayoutConstraint!

    var leadingConstraintHorizontal: NSLayoutConstraint!
    var leadingConstraintVertical: NSLayoutConstraint!

    let screenSize: CGRect = UIScreen.mainScreen().bounds

    var animatingViewOriginalCenter: CGPoint!

    var arrayOfCustomViews: [UIView]!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        arrayOfCustomViews = [UIView()]

        //KGNAutoLayout
        leadingConstraintVertical = animatingView.pinToTopEdgeOfSuperview(offset: 65)
        leadingConstraintHorizontal = animatingView.pinToLeftEdgeOfSuperview(offset: 54)
        animatingLabel.centerInSuperview()
        //loveYourselfButton.centerInSuperview()


        //animatingView.
        //print(animatingLabel.center.x)
        //print(view.bounds.width)
        //animatingView.center.x  -= view.bounds.width //doesnt work
        //print(animatingLabel.center.x)

        //print(randomXPositionInWindow())

        // The onCustomTap: method will be defined in Step 3 below.
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.onCustomPan(_:)))
        //var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
        // set delegate
        panGestureRecognizer.delegate = self
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        animatingView.userInteractionEnabled = true
        animatingView.addGestureRecognizer(panGestureRecognizer)
    }

    func addCustomView (completion:(view: UIView) -> Void) {
        let customView = UIView(frame: CGRect(x: randomXPositionInWindow(), y: Int(screenSize.height), width: 50, height: 50))
        //customView.backgroundColor = UIColor.redColor()
        let customLabel = UILabel()
        customLabel.textAlignment = NSTextAlignment.Center
        customLabel.text = "💙"
        customView.addSubview(customLabel)
        customLabel.centerInSuperview()
        self.view.addSubview(customView)
        //print(arrayOfCustomViews)
        arrayOfCustomViews.append(customView)
        completion(view: customView)
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

    func randomNumberBetweenZeroAndN (n: Int) -> Int {
        //return random value between 0 and n
        return Int(arc4random_uniform(UInt32(n)) + 1)
    }

    // gives view a random x position within the window bounds
    // might want to pass the function a dynamic value instead of 50 that represents the width of the CustomView we're giving a position for
    func randomXPositionInWindow () -> Int {
        //print(screenWidth)
        //return random value between 0 and screensize.width
        return randomNumberBetweenZeroAndN(Int(screenSize.width-50))
    }


    //**give custom view this function or give each custom view their own leadingConstraintVertical and horizontal attributes
    func animateViewToTop(viewToAnimate: UIView) {


        // 1
        //let newConstraint = NSLayoutConstraint(item: viewToAnimate, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1.0, constant: self.view.frame.height)

        // 2
        UIView.animateWithDuration(NSTimeInterval(randomNumberBetweenZeroAndN(5)), delay: NSTimeInterval(randomNumberBetweenZeroAndN(2)), options: .CurveEaseOut , animations: {
            //viewToAnimate.removeConstraint(self.leadingConstraintVertical)
            //            self.view.addConstraint(newConstraint)
            //            self.view.layoutIfNeeded()
            //print(viewToAnimate.constraints)
            viewToAnimate.pinToTopEdgeOfSuperview(offset: 0 - viewToAnimate.frame.height)
            //viewToAnimate.pinToLeftEdgeOfSuperview(offset: CGFloat(self.screenSize.width/2))
            viewToAnimate.pinToLeftEdgeOfSuperview(offset: viewToAnimate.frame.origin.x + viewToAnimate.frame.width)
            viewToAnimate.layoutIfNeeded()
            }, completion: { (Bool) -> Void in
                viewToAnimate.removeFromSuperview()
        })



        // 3
        //leadingConstraintVertical = newConstraint
    }

    func letItFly() {
        let customView = UIView(frame: CGRect(x: randomXPositionInWindow(), y: Int(screenSize.height) + 100, width: 50, height: 50))
        //customView.backgroundColor = UIColor.redColor()
        let customLabel = UILabel()
        customLabel.textAlignment = NSTextAlignment.Center
        customLabel.text = "💙"
        customView.addSubview(customLabel)
        customLabel.centerInSuperview()
        self.view.addSubview(customView)
        //print(arrayOfCustomViews)
        //arrayOfCustomViews.append(customView)
        //completion(view: customView)

        self.animateViewToTop(customView)
//
//        addCustomView() {
//            (view: UIView) in
//            self.animateViewToTop(view)
//        }
        //animateViewToTop(addedView)
    }

    @IBAction func animateViewWithLabel(sender: AnyObject) {
        //print(arrayOfCustomViews.count)
        //randomXPositionForViewInWindow -- at least 3 hearts maybe 9
        let numberOfHearts: Int = Int(randomNumberBetweenZeroAndN(6) + 3)
        var i: Int = 0
        while i < numberOfHearts {
            letItFly()
            i += 1
        }
//        if let viewToAnimate = sender as? UIView {
//            //animateViewToTop(viewToAnimate)
//            animateViewToTop(arrayOfCustomViews[1])
//            for view in arrayOfCustomViews {
//                animateViewToTop(view)
//            }
//        } else {
//            // 1
//            let newConstraint = NSLayoutConstraint(item: animatingView, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1.0, constant: self.view.frame.width)
//
//            // 2
//            UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseOut , animations: {
//                self.view.removeConstraint(self.leadingConstraintVertical)
//                //            self.view.addConstraint(newConstraint)
//                //            self.view.layoutIfNeeded()
//                //print(self.animatingView.constraints)
//                self.animatingView.pinToRightEdgeOfSuperview(offset: 0 - self.animatingView.frame.width)
//                self.view.layoutIfNeeded()
//                }, completion: nil)
//
//            // 3
//            leadingConstraintHorizontal = newConstraint
//        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

