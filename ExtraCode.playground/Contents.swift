//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//
//  ExtraCode.swift
//  loveyourself
//
//  Created by David Fontenot on 5/27/16.
//  Copyright © 2016 David Fontenot. All rights reserved.
//

import Foundation

//##add gesture recognizers to hearts soon

func addPanGestureRecognizerToView(view: UIView) {
    // The onCustomTap: method will be defined in Step 3 below.
    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.onCustomPan(_:)))
    //var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
    // set delegate
    panGestureRecognizer.delegate = self
    // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
    view.userInteractionEnabled = true
    view.addGestureRecognizer(panGestureRecognizer)
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
        sender.view!.center = CGPoint(x: animatingViewOriginalCenter.x + translation.x, y: animatingViewOriginalCenter.y + translation.y)
    } else if sender.state == UIGestureRecognizerState.Ended {
        print("Gesture ended at: \(point)")
    }
}

func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
}