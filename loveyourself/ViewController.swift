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

    @IBOutlet weak var loveYourselfButton: UIButton!

    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var animatingViewOriginalCenter: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func animateViewWithLabel(sender: AnyObject) {
        //randomXPositionForViewInWindow -- at least 3 hearts maybe 9 per click
        let numberOfHearts: Int = Int(randomNumberBetweenZeroAndN(6) + 3)
        var i: Int = 0
        while i < numberOfHearts {
            letItFly()
            i += 1
        }
    }

    func letItFly() {
        addCustomView() {
            (view: UIView) in
            self.animateViewToTop(view)
        }
    }

    func animateViewToTop (viewToAnimate: UIView) {
        UIView.animateWithDuration(NSTimeInterval(randomDoubleBetweenZeroAndN(5)), delay: NSTimeInterval(randomDoubleBetweenZeroAndN(2)), options: .CurveEaseOut , animations: {
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
    }

    func addCustomView (completion:(view: UIView) -> Void) {
        let customView = UIView(frame: CGRect(x: randomXPositionInWindow(), y: Int(screenSize.height), width: 50, height: 50))
        let customLabel = UILabel()
        customLabel.textAlignment = NSTextAlignment.Center
        customLabel.text = "💙"
        customView.addSubview(customLabel)
        customLabel.centerInSuperview()
        //addPanGestureRecognizerToView(customView)
        self.view.addSubview(customView)
        customView.layoutIfNeeded()

        completion(view: customView)
    }

    // ## Random Number Generators should be decimal for more variation**

    func randomDoubleBetweenZeroAndN(n: Int) -> Double {
        let firstNumber: Double = Double(randomNumberBetweenZeroAndN(n-1))
        let secondNumber: Double = Double(randomNumberBetweenZeroAndN(100))/100
        let doubleNumber = firstNumber + secondNumber
        return doubleNumber
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

