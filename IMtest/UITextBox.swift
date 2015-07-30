//
//  UITextBox.swift
//  UITest
//
//  Created by 李招利 on 14/7/10.
//  Copyright (c) 2014年 慧趣工作室. All rights reserved.
//

import UIKit

//enum UITextBoxContentType {
//    case AnyChar
//    case Number
//    case Integer
//    case EMail
//    case Phone
//    case Telephone
//    case MobilePhone
//    case CustomType
//}


enum UITextBoxHighlightState {
    case Default
    case Validator  (String)    // 状态提示文字
    case Warning    (String)    // 状态提示文字
    case Wrong      (String)    // 状态提示文字
}

@IBDesignable

class UITextBox: UITextField {
    
    @IBInspectable var wrongColor:UIColor       = UIColor(number: 0xFFEEEE) // 淡红色
    @IBInspectable var warningColor:UIColor     = UIColor(number: 0xFFFFCC) // 淡黄色
    @IBInspectable var validatorColor:UIColor   = UIColor(number: 0xEEFFEE) // 淡绿色
    @IBInspectable var highlightColor:UIColor   = UIColor(number: 0xEEF7FF) // 淡蓝色
    
    @IBInspectable var animateDuration:CGFloat = 0.4
    weak var placeholderLabel:UILabel?
    
    @NSCopying private var _backgroundColor: UIColor? = nil
    override var backgroundColor: UIColor? {
        set {
            _backgroundColor = newValue
            super.backgroundColor = self.getHighlightColor(self.highlightState)
        }
        get {
            return _backgroundColor
        }
    }
    override var attributedPlaceholder: NSAttributedString? {
    didSet {
        if let label = placeholderLabel {
            label.attributedText = super.attributedPlaceholder
            self.layoutSubviews()
        }
    }
    }
    override var placeholder:String? {
    didSet {
        if let label = placeholderLabel {
            label.text = super.placeholder
            self.layoutSubviews()
        }
    }
    }
    
    
    private var _highlightState:UITextBoxHighlightState {
        return text == nil || text == "" ? .Default : highlightState
    }
    var highlightState:UITextBoxHighlightState = .Default {
    didSet {
        if let label = placeholderLabel {
            setHighlightText(label, state: _highlightState)
            self.layoutSubviews()
        }
        UIView.animateWithDuration(NSTimeInterval(animateDuration)) {
            super.backgroundColor = self.getHighlightColor(self._highlightState)
            
        }
    }
    }
    
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.addTarget(self, action: Selector("editingChanged"), forControlEvents: UIControlEvents.EditingChanged);
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        self.addTarget(self, action: Selector("editingChanged"), forControlEvents: UIControlEvents.EditingChanged);
//    }
//    
//    func editingChanged() {
//        print("editingChanged:\(text)")
//    }
    
    //获得焦点时高亮动画
    override func becomeFirstResponder() -> Bool {
        return animationFirstResponder(super.becomeFirstResponder())
    }
    
    //失去焦点时取消高亮动画
    override func resignFirstResponder() -> Bool {
        return animationFirstResponder(super.resignFirstResponder())
    }
    
    //
    private func animationFirstResponder(isFirstResponder:Bool) -> Bool {
        UIView.animateWithDuration(NSTimeInterval(animateDuration)) {
            let color = self.getHighlightColor(self._highlightState)
            super.backgroundColor = color
            self.placeholderLabel?.textColor = self.getTextColorWithHighlightColor(color)
        }
        return isFirstResponder
    }
    
    
    //调整子控件布局
    override func layoutSubviews() {
        super.layoutSubviews()
        let rect = super.placeholderRectForBounds(bounds)
        if isFirstResponder() {
            layoutPlaceholderLabel(rect,false)
        } else if text == nil || text == "" {
            layoutPlaceholderLabel(rect,true)
        } else {
            layoutPlaceholderLabel(rect,false)
        }
    }
    
    override func willMoveToSuperview(newSuperview: UIView!)  {
        super.willMoveToSuperview(newSuperview)
        if placeholderLabel == nil {
            let rect = super.placeholderRectForBounds(bounds)
            let label = UILabel(frame: rect)
            label.font = self.font
            setHighlightText(label, state: self._highlightState)
            placeholderLabel = label
            self.addSubview(label);
        }
    }
    
    override func removeFromSuperview() {
        self.placeholderLabel?.removeFromSuperview()
        self.placeholderLabel = nil
        super.removeFromSuperview()
    }
    

    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        let rect = super.placeholderRectForBounds(bounds)
        if placeholderLabel == nil {
            let label = UILabel(frame: rect)
            label.textColor = UIColor(white: 0.7, alpha: 1.0)
            label.font = self.font
            placeholderLabel = label
            addSubview(label)
        }
        setHighlightText(placeholderLabel!, state: self._highlightState)
        layoutPlaceholderLabel(rect,!isFirstResponder())
        return CGRect.zeroRect
    }
    
    
    //布局提示文本
    func layoutPlaceholderLabel(rect: CGRect,_ left: Bool = false) {
        guard let label = placeholderLabel else {
            return
        }
        
        if left {
            UIView.animateWithDuration(NSTimeInterval(animateDuration), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
                label.frame = rect;
            }, completion: nil)
        } else {
            let size = label.sizeThatFits(rect.size)
            var frame = rect
            frame.size.width = size.width
            frame.size.height = rect.height
            //print("super.clearButtonRectForBounds(bounds):\(super.clearButtonRectForBounds(bounds))")
            frame.origin.x = super.clearButtonRectForBounds(bounds).minX - size.width
            UIView.animateWithDuration(NSTimeInterval(animateDuration), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
                label.frame = frame;
            }, completion: nil)
        }
    }
    
    private func setHighlightText(label:UILabel, state:UITextBoxHighlightState) {
        switch state {
        case .Wrong(let errorText):
            label.textColor = getTextColorWithHighlightColor(wrongColor)
            label.text = errorText
        case .Warning(let warningText):
            label.textColor = getTextColorWithHighlightColor(warningColor)
            label.text = warningText
        case .Validator(let validatorText):
            label.textColor = getTextColorWithHighlightColor(validatorColor)
            label.text = validatorText
        default:
            if let attributedPlaceholder = self.attributedPlaceholder {
                label.attributedText = attributedPlaceholder
            } else {
                label.text = self.placeholder
            }
            label.textColor = getTextColorWithHighlightColor(getHighlightColor(_highlightState))
        }
    }
    private func getTextColorWithHighlightColor(color:UIColor) -> UIColor {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: r*r*0.7, green: g*g*0.7, blue: b*b*0.7, alpha: a)   // 同类颜色加深一些
    }
    private func getHighlightColor(state:UITextBoxHighlightState) -> UIColor {
        switch state {
        case .Wrong:        return wrongColor
        case .Warning:      return warningColor
        case .Validator:    return validatorColor
        default:            return self.isFirstResponder() ? highlightColor : self.backgroundColor ?? UIColor.whiteColor()
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}

extension UIColor {
    convenience init(number:UInt32) {
        let b = CGFloat(number & 0xFF) / 255
        let g = CGFloat((number >> 8) & 0xFF) / 255
        let r = CGFloat((number >> 16) & 0xFF) / 255
        let a = number > 0xFFFFFF ? CGFloat((number >> 24) & 0xFF) / 255 : 1.0
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    convenience init?(hex:String) {
        let regular:NSRegularExpression
        do {
            regular = try NSRegularExpression(pattern: "(#?|0x)[0-9a-fA-F]{2,}", options: NSRegularExpressionOptions.CaseInsensitive)
        } catch { return nil }
        
        let length = distance(hex.startIndex, hex.endIndex)
        guard let result = regular.firstMatchInString(hex, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, length)) else {
            print("error: hex isn't color hex value!")
            return nil
        }
        
        let start = advance(hex.startIndex, result.rangeAtIndex(1).length + result.rangeAtIndex(1).location)
        let end = advance(hex.startIndex, result.range.length + result.range.location)
        let number = strtoul(hex[start..<end], nil, 16)
        let b = CGFloat((number >>  0) & 0xFF) / 255
        let g = CGFloat((number >>  8) & 0xFF) / 255
        let r = CGFloat((number >> 16) & 0xFF) / 255
        let a = distance(start, end) > 6 ? CGFloat((number >> 24) & 0xFF) / 255 : 1
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
