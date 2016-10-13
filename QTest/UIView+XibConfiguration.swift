//
//  UIView+XibConfiguration.swift
//  Dollars
//
//  Created by TM Mac 01 on 8/4/16.
//  Copyright © 2016 ShahNewaz. All rights reserved.
//

import UIKit
import ObjectiveC

var AssociatedObjectHandle: UInt8 = 0

extension UIView {

    @IBInspectable var cornerRadius:CGFloat {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as! CGFloat
        }
        set {
            self.layer.cornerRadius = newValue
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    @IBInspectable var borderWidth:CGFloat {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as! CGFloat
        }
        set {
            self.layer.borderWidth = newValue
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    @IBInspectable var borderColor:UIColor {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as! UIColor
        }
        set {
            self.layer.borderColor = newValue.cgColor
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}

extension UITextField {
    @IBInspectable var leftPadding:CGFloat {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as! CGFloat
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: self.bounds.height))
            self.leftView = paddingView
            self.leftViewMode = UITextFieldViewMode.always
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    @IBInspectable var rightPadding:CGFloat {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as! CGFloat
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: self.bounds.height))
            self.rightView = paddingView
            self.rightViewMode = UITextFieldViewMode.always
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}


/*
 //UPDATED for Swift 3.0
 
private var nextFieldAssocKey = 0
extension UITextField {
    @IBOutlet var nextField: UITextField? {
        get {
            return objc_getAssociatedObject(self, &nextFieldAssocKey) as? UITextField
        }
        set {
            objc_setAssociatedObject(self, &nextFieldAssocKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}
 */
