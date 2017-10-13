//
//  CustomField.swift
//  JSONParsingUsingDecodable
//
//  Created by Varun Yadav on 10/12/17.
//  Copyright © 2017 Varun Yadav. All rights reserved.
//

import UIKit

@IBDesignable
class CustomField: UITextField {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.borderColor = UIColor(white: 231 / 255, alpha: 1).cgColor
        self.layer.borderWidth = 1
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 7)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    
}
