//
//  UIView+StringTag.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/1.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

/**
 Use more human readable string tag instead of integer
 */
public extension UIView {
    
    /**
     A string that you can use to identify view objects in your application.
     This library will try to generate a `UIView.tag` for this view.
     
     The default value is nil. You can set the value of this tag and use that value to identify the view later.
     */
    @IBInspectable public var stringTag: String? {
        get {
            if (self.tag == 0) {
                return nil
            } else {
                return UIView.tagPool.filter { (k, v) -> Bool in return v == self.tag }.first!.0
            }
        }
        set {
            if (newValue == nil) {
                self.tag = 0
            } else {
                if let intTag = UIView.tagPool[newValue!] {
                    self.tag = intTag
                } else {
                    let newTag = UIView.tagPool.count + 101
                    UIView.tagPool[newValue!] = newTag
                    self.tag = newTag
                }
            }
        }
    }
    
    /**
     Find corresponding view with specified string tag
     
     - parameter stringTag: String tag of desired view
     - returns: First view with given tag, `nil` otherwise
     */
    public func viewWithStringTag(stringTag: String) -> UIView? {
        guard let intTag = UIView.tagPool[stringTag] else {
            return nil
        }
        return viewWithTag(intTag)
    }
    
    internal static func getTag(byStringTag tag: String?) -> Int {
        if (tag == nil) {
            return 0
        }
        guard let intTag = tagPool[tag!] else {
            fatalError("String tag '\(tag!)' not found")
        }
        return intTag
    }
    
    internal static func getStringTag(byTag tag: Int) -> String? {
        if (tag == 0) {
            return nil
        }
        return tagPool.filter { (k, v) -> Bool in return v == tag }.first?.0
    }
    
    private static var tagPool = [String: Int]()
}
