//
//  Utils.swift
//  Businesslance
//
//  Created by Keerthika Chokkalingam on 15/09/23.
//

import Foundation
import UIKit

class Utils {
    func setUpLoader(sender: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = sender.center
        activityIndicator.color = UIColor.gray
        activityIndicator.tag = 444
        sender.addSubview(activityIndicator)
        return activityIndicator
    }
    func startLoading(sender: UIActivityIndicatorView, wholeView: UIView) {
        if let indicator = sender.viewWithTag(444) as? UIActivityIndicatorView {
            indicator.isHidden = false
            indicator.startAnimating()
        }
    }
    func endLoading(sender: UIActivityIndicatorView, wholeView: UIView) {
        if let indicator = sender.viewWithTag(444) as? UIActivityIndicatorView {
            indicator.isHidden = true
            indicator.hidesWhenStopped = true
            indicator.stopAnimating()
        }
    }
}
