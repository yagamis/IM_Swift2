//The DKDropMenu License
//
//Copyright (c) 2015 David Kopec
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

//
//  DKDropMenu.swift
//  DKDropMenu
//
//  Created by David Kopec on 6/5/15.
//  Copyright (c) 2015 Oak Snow Consulting. All rights reserved.
//

import UIKit

/// Delegate protocol for receiving change in list selection
@objc public protocol DKDropMenuDelegate {
    func itemSelectedWithIndex(index: Int, name:String)
    optional func collapsedChanged()
}

/// A simple drop down list like expandable menu for iOS
@IBDesignable
public class DKDropMenu: UIView {
    
    @IBInspectable public var itemHeight: CGFloat = 44
    @IBInspectable public var selectedFontName: String = "HelveticaNeue-Bold"
    @IBInspectable public var listFontName: String = "HelveticaNeue-Thin"
    @IBInspectable public var textColor: UIColor = UIColor.darkGrayColor()
    @IBInspectable public var outlineColor: UIColor = UIColor.lightGrayColor()
    @IBInspectable public var selectedColor: UIColor = UIColor.greenColor()
    weak public var delegate: DKDropMenuDelegate? = nil  //notified when a selection occurs
    private var items: [String] = [String]()
    public var selectedItem: String? = nil {
        didSet {
            setNeedsDisplay()
        }
    }
    public var collapsed: Bool = true {
        didSet {
            delegate?.collapsedChanged?()
            //animate collapsing or opening
            UIView.animateWithDuration(0.5, delay: 0, options: .TransitionCrossDissolve, animations: {
                var tempFrame = self.frame
                if (self.collapsed) {
                    tempFrame.size.height = self.itemHeight
                } else {
                    if (self.items.count > 1 && self.selectedItem != nil) {
                        tempFrame.size.height = self.itemHeight * CGFloat(self.items.count)
                    } else if (self.items.count > 0 && self.selectedItem == nil) {
                        tempFrame.size.height = self.itemHeight * CGFloat(self.items.count) + self.itemHeight
                    }
                }
                self.frame = tempFrame
                self.invalidateIntrinsicContentSize()
                }, completion: nil)
            setNeedsDisplay()
        }
    }
    
    // MARK: Overridden standard UIView methods
    override public func sizeThatFits(size: CGSize) -> CGSize {
        if (items.count < 2 || collapsed) {
            return CGSize(width: size.width, height: itemHeight)
        } else {
            return CGSize(width: size.width, height: (itemHeight * CGFloat(items.count)))
        }
    }
    
    override public func intrinsicContentSize() -> CGSize {
        if (items.count < 2 || collapsed) {
            return CGSize(width: bounds.size.width, height: itemHeight)
        } else {
            return CGSize(width: bounds.size.width, height: (itemHeight * CGFloat(items.count)))
        }
    }
    
    override public func drawRect(rect: CGRect) {
        // Drawing code
        //draw first box regardless
        let context = UIGraphicsGetCurrentContext()
        outlineColor.setStroke()
        CGContextSetLineWidth(context, 1.0)
        CGContextMoveToPoint(context, 0, itemHeight)
        CGContextAddLineToPoint(context, 0, 0.5)
        CGContextAddLineToPoint(context, frame.size.width, 0.5)
        CGContextAddLineToPoint(context, frame.size.width, itemHeight)
        CGContextStrokePath(context)
        if let sele = selectedItem {
            //draw item text
            var paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .Center
            let attrs = [NSFontAttributeName: UIFont(name: selectedFontName, size: 16)!, NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: textColor]
            if (collapsed) {
                let tempS = "\(sele)"  //put chevron down facing here if right unicode found
                tempS.drawInRect(CGRect(x: 20, y: itemHeight / 2 - 10, width: frame.size.width - 20, height: 20), withAttributes: attrs)
            } else {
                let tempS = "\(sele)"  //put chevron up facing here if right unicode found
                tempS.drawInRect(CGRect(x: 20, y: itemHeight / 2 - 10, width: frame.size.width - 20, height: 20), withAttributes: attrs)
            }
            //draw selected line
            selectedColor.setStroke()
            CGContextMoveToPoint(context, 0, itemHeight - 2)
            CGContextSetLineWidth(context, 4.0)
            CGContextAddLineToPoint(context, frame.width, itemHeight - 2)
            CGContextStrokePath(context)
        } else {
            CGContextMoveToPoint(context, 0, itemHeight - 1)
            CGContextSetLineWidth(context, 1.0)
            CGContextAddLineToPoint(context, frame.width, itemHeight - 1)
            CGContextStrokePath(context)
        }
        //draw lower boxes
        if (!collapsed && items.count > 1) {
            var currentY = itemHeight
            for item in items {
                if item == selectedItem {
                    continue
                }
                //draw box
                outlineColor.setStroke()
                CGContextSetLineWidth(context, 1.0)
                CGContextMoveToPoint(context, 0, currentY)
                CGContextAddLineToPoint(context, 0, currentY + itemHeight)
                CGContextStrokePath(context)
                CGContextSetLineWidth(context, 0.5)
                CGContextMoveToPoint(context, 0, currentY + itemHeight - 1)
                CGContextAddLineToPoint(context, frame.size.width, currentY + itemHeight - 1)
                CGContextStrokePath(context)
                CGContextSetLineWidth(context, 1.0)
                CGContextMoveToPoint(context, frame.size.width, currentY + itemHeight)
                CGContextAddLineToPoint(context, frame.size.width, currentY)
                CGContextStrokePath(context)
                //draw item text
                var paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .Center
                let attrs = [NSFontAttributeName: UIFont(name: listFontName, size: 16)!, NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: textColor]
                item.drawInRect(CGRect(x: 20, y: currentY + (itemHeight / 2 - 10), width: frame.size.width - 20, height: 20), withAttributes: attrs)
                currentY += itemHeight
            }
        }
    }
    
    // MARK: Add or remove items
    /// Add an array of items to the menu
    public func addItems(names: [String]) {
        for name in names {
            addItem(name)
        }
    }
    
    /// Add a single item to the menu
    public func addItem(name: String) {
        //if we have no selected items, we'll take it
        if items.isEmpty {
            selectedItem = name
        }
        
        items.append(name)
        
        //animate change
        if (!collapsed && items.count > 1) {
            UIView.animateWithDuration(0.7, delay: 0, options: .CurveEaseOut, animations: {
                var tempFrame = self.frame
                tempFrame.size.height = self.itemHeight * CGFloat(self.items.count)
                self.frame = tempFrame
                }, completion: nil)
        }
        
        //refresh display
        setNeedsDisplay()
    }

    /// Remove a single item from the menu
    public func removeItemAtIndex(index: Int) {
        if (items[index] == selectedItem) {
            selectedItem = nil
        }
        items.removeAtIndex(index)
        //animate change
        if (!collapsed && items.count > 1) {
            UIView.animateWithDuration(0.7, delay: 0, options: .CurveEaseOut, animations: {
                var tempFrame = self.frame
                tempFrame.size.height = self.itemHeight * CGFloat(self.items.count)
                self.frame = tempFrame
                }, completion: nil)
        } else if (!collapsed) {
            UIView.animateWithDuration(0.7, delay: 0, options: .CurveEaseOut, animations: {
                var tempFrame = self.frame
                tempFrame.size.height = self.itemHeight
                self.frame = tempFrame
                }, completion: nil)
        }
        
        setNeedsDisplay()
    }
    
    /// Remove the first occurence of item named *name*
    public func removeItem(name: String) {
        if let index = find(items, name) {
            removeItemAtIndex(index)
        }
    }
    
    // MARK: Events
    override public func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch:UITouch = touches.first as! UITouch
        let point:CGPoint = touch.locationInView(self)
        if point.y > itemHeight {
            if let dele = delegate {
                var thought = Int(point.y / itemHeight) - 1
                if let sele = selectedItem {
                    if find(items, sele) <= thought {
                        thought += 1
                    }
                }
                dele.itemSelectedWithIndex(thought, name: items[thought])
                selectedItem = items[thought]
            }
        }
        collapsed = !collapsed
    }
}
