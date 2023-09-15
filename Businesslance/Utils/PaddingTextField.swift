//
//  PaddingTextField.swift
//  Businesslance
//
//  Created by Keerthika Chokkalingam on 15/09/23.
//

import Foundation
import UIKit

class PaddingTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) // Adjust the padding as needed

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
