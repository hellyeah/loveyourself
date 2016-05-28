//
//  ViewController.swift
//  loveyourself
//
//  Created by David Fontenot on 5/27/16.
//  Copyright © 2016 David Fontenot. All rights reserved.
//

import UIKit
import KGNAutoLayout
import PureLayout

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var loveYourselfButton: UIButton!
    @IBAction func tapView(sender: AnyObject) {
        self.animateHearts(sender)
    }

    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var animatingViewOriginalCenter: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func animateHearts(sender: AnyObject) {
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
    
    func animateViewToTop (viewToAnimate: UIView) {
        
        // start off tilted with a range of +- 30 degrees to create floaty effect as if the hearts are floating up through water
        let tiltValue = 30.0 - Double(self.randomNumberBetweenZeroAndN(60))
        viewToAnimate.transform = CGAffineTransformMakeRotation(CGFloat(tiltValue / 180.0 * M_PI))
        UIView.animateWithDuration(NSTimeInterval(randomDoubleBetweenZeroAndN(5)), delay: NSTimeInterval(randomDoubleBetweenZeroAndN(2)), options: .CurveEaseOut , animations: {

                viewToAnimate.pinToTopEdgeOfSuperview(offset: 0 - viewToAnimate.frame.height)
                viewToAnimate.pinToLeftEdgeOfSuperview(offset: viewToAnimate.frame.origin.x + viewToAnimate.frame.width)
            
                // rotate back to 0 degrees which is level
                viewToAnimate.transform = CGAffineTransformMakeRotation(CGFloat(0.0 / 180.0 * M_PI))
            
                viewToAnimate.layoutIfNeeded()
            
            }, completion: { (Bool) -> Void in
                viewToAnimate.removeFromSuperview()
            })
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

